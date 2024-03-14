library(mapboxapi)
library(leaflet)
library(readr)
library(dplyr)
library(janitor)
library(sf)
library(here)

mills <- read_csv(here("data", "mill_database.csv")) |>
  clean_names() |>
  filter(!is.na(latitude), source != "dummy")

mills <- mills |>
  st_as_sf(coords=c("longitude", "latitude"), crs=4326) |>
  dplyr::mutate(looks_like_mill = grepl("yes", looks_like_mill_logs_and_or_sawdust_visible))
  
mapview::mapview(mills, zcol="looks_like_mill", col.regions=c("red", "dodgerblue"))

table(mills$source, mills$looks_like_mill)

sum(mills$looks_like_mill)

mills <- mills |>
  dplyr::filter( looks_like_mill_logs_and_or_sawdust_visible=="yes")

isochrone_list <- list()
print(nrow(mills))
for (i in 1:nrow(mills)) {
  tmp <- mb_isochrone(
    c(mills$longitude[i], mills$latitude[i]), 
    distance=100000, # 62.1371 miles max haul distance (can only request up to 100km)
  )
  isochrone_list[[i]] <- tmp
  print(i)
}


isochrones <- bind_rows(isochrone_list) |>
  bind_cols(mills)

mapview::mapview(isochrones, alpha.regions=0.2)

# pull mtbs directly from USGS using virtual filesystems (is not fast)
mtbs <- sf::st_read("/vsizip/vsicurl/https://edcintl.cr.usgs.gov/downloads/sciweb1/shared/MTBS_Fire/data/composite_data/burned_area_extent_shapefile/mtbs_perimeter_data.zip/mtbs_perims_DD.shp") |>
  filter(BurnBndAc > 1000)

proj_iso <- isochrones |>
  st_transform(st_crs(mtbs)) |>
  st_buffer(0) |> 
  st_make_valid()

sf_use_s2(FALSE)

aoi_mtbs <- st_crop(mtbs, proj_iso) |>
  st_simplify(dTolerance = 0.001)

joined <- st_intersection(aoi_mtbs, proj_iso)

mapview::mapview(joined) + mapview::mapview(proj_iso)

mill_burned_areas <- joined |>
  group_by(id) |>
  summarize()

# compute area served by each mill
proj_iso$area <- proj_iso |>
  st_transform(5070) |>
  st_area() |>
  as.numeric()

# compute area burned within each reachable area
mill_burned_areas$burned_area <- mill_burned_areas |>
  st_transform(5070) |>
  st_area() |>
  as.numeric()

final_mills <- proj_iso |>
  left_join(mill_burned_areas |> st_drop_geometry()) |>
  mutate(frac_burned = burned_area / area)

final_mills |>
  mapview::mapview(zcol="frac_burned")

final_mills |>
  sf::write_sf("mill-isochrones.gpkg")

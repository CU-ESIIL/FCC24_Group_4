# Project methods overview

## Data Sources

- [Colorado Forest Products Database](https://csfs.colostate.edu/colorado-forest-products-database/): a list of companies that make wood products, which includes some mills.
- [Wyoming Wood Products Facilities](https://www.arcgis.com/home/item.html?id=e4dd25c0b5904a86b8a6ea0a2c4f55e4): a list of companies in Wyoming that generate wood products, derived from FIA survey data.
- [OpenStreetMap](https://www.openstreetmap.org/): crowd-sourced spatial data on roads, buildings, etc.
- [National Agriculture Imagery Program](https://www.usgs.gov/centers/eros/science/usgs-eros-archive-aerial-photography-national-agriculture-imagery-program-naip): USDA high resolution aerial imagery.

## Data Processing Steps

### Constructing a mill database

We mapped mills by first collecting three sets of candidate mills from OpenStreetMap, the Colorado Forest Products Database, and the Wyoming Wood Products Facilities database.
For every candidate mill, we used Google Maps to search for the address, then visually interpreted imagery from the Google Satellite basemap layer to detect evidence of milling.
Our criteria were 1) visible stacks of logs and/or boards, or 2) visible sawdust piles. 
While these criteria would exclude small operations or those that are entirely indoors, we decided to accept this as a limitation as our eventual goal was to assess the use of remote sensing data for monitoring mill activity. 
Each mill was categorized as having visible logs/boards or a sawdust pile, and this information was entered into a shared spreadsheet. 
Additionally we geocoded addresses to get spatial coordinates of mill locations.

## Data Analysis
Describe steps taken to analyze data and resulting files in team data store file structure.

### segment_geospatial
Using the samgeo package in Python (https://samgeo.gishub.org/) we tested three methods for detection of log piles. We envision this to be a quick way to distinguish area of log piles at a sawmill, potentially serving as a metric of production. We tested these methods on one site.

We first tested text prompting, which ended up being our best performing method. Using the code provided on the package website (https://samgeo.gishub.org/examples/text_prompts/), we entered the phrase "find stacks of lumber or stacks of logs". The center of the sawmill (coordinates on OSM) were used as the center of the plot and area of interest (AOI) was bounded by the min/max long/lat of the sawmill area. The code exports a tif, which can then be viewed in QGIS or another GIS software. Areas identified as log piles are white pixels while the background is black. If someone was interested in finding or tracking the area of log piles, you would find the area of one pixel then find the number of pixels coded as white.

We then tested input prompting, which entailed dropping a point on log piles and dropping points on the background to differentiate. We followed the code provided on the package website (https://samgeo.gishub.org/examples/input_prompts/). This method highlighted the majority of the the sawmill, so it would not be useful for identifying log piles.

Finally we tested the automatic mask generator (https://samgeo.gishub.org/examples/automatic_mask_generator/) which distinguished all the unique options in the AOI. This performed pretty well, but did not pick up as many log piles as the text prompting. 

## Visualizations
Describe visualizations created and any specialized techniques or libraries that users should be aware of.

## Conclusions
Summary of the full workflow and its outcomes. Reflect on the methods used.

## References
Citations of tools, data sources, and other references used.

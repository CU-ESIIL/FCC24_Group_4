# Project methods overview

## Data Sources

- [Colorado Forest Products Database](https://csfs.colostate.edu/colorado-forest-products-database/): a list of companies that make wood products, which includes some mills.
- [Wyoming Wood Products Facilities](https://www.arcgis.com/home/item.html?id=e4dd25c0b5904a86b8a6ea0a2c4f55e4): a list of companies in Wyoming that generate wood products, derived from FIA survey data.
- [OpenStreetMap](https://www.openstreetmap.org/): crowd-sourced spatial data on roads, buildings, etc.
- [National Agriculture Imagery Program](https://www.usgs.gov/centers/eros/science/usgs-eros-archive-aerial-photography-national-agriculture-imagery-program-naip): USDA high resolution aerial imagery.
- [Monitoring Trends in Burn Severity (MTBS)](https://www.mtbs.gov/): fire boundary data

## Data Processing Steps

### Constructing a mill database

We mapped mills by first collecting three sets of candidate mills from OpenStreetMap, the Colorado Forest Products Database, and the Wyoming Wood Products Facilities database.
For every candidate mill, we used Google Maps to search for the address, then visually interpreted imagery from the Google Satellite basemap layer to detect evidence of milling.
Our criteria were 1) visible stacks of logs and/or boards, or 2) visible sawdust piles. 
While these criteria would exclude small operations or those that are entirely indoors, we decided to accept this as a limitation as our eventual goal was to assess the use of remote sensing data for monitoring mill activity. 
Each mill was categorized as having visible logs/boards or a sawdust pile, and this information was entered into a shared spreadsheet. 
Additionally we geocoded addresses to get spatial coordinates of mill locations.

## Data Analysis

### segment_geospatial
Using the samgeo package in Python (https://samgeo.gishub.org/) we tested three methods for detection of log piles. We envision this to be a quick way to distinguish area of log piles at a sawmill, potentially serving as a metric of production. We tested these methods on one site.

We first tested text prompting, which ended up being our best performing method. Using the code provided on the package website (https://samgeo.gishub.org/examples/text_prompts/), we entered the phrase "find stacks of lumber or stacks of logs". The center of the sawmill (coordinates on OSM) were used as the center of the plot and area of interest (AOI) was bounded by the min/max long/lat of the sawmill area. The code exports a tif, which can then be viewed in QGIS or another GIS software. Areas identified as log piles are white pixels while the background is black. If someone was interested in finding or tracking the area of log piles, you would find the area of one pixel then find the number of pixels coded as white.

We then tested input prompting, which entailed dropping a point on log piles and dropping points on the background to differentiate. We followed the code provided on the package website (https://samgeo.gishub.org/examples/input_prompts/). This method highlighted the majority of the the sawmill, so it would not be useful for identifying log piles.

Finally we tested the automatic mask generator (https://samgeo.gishub.org/examples/automatic_mask_generator/) which distinguished all the unique options in the AOI. This performed pretty well, but did not pick up as many log piles as the text prompting. 

### Mapping disturbances within mill isochrones

To understand how mills might be impacted by disturbance we quantified overlap of mill isochrones (areas accessible if one could haul wood up to 62 miles) and wildfires (from the MTBS data). 
Mill isochrones were computed using the `mapboxapi` R package. 
While wood can be hauled distances greater than 62 miles, the API restricts the maximum travel distance to 100 km (~62 miles). 
Once we overlaid isochrones and fire, we computed the fraction of isochrone that had burned for each mill. 

### Naive Bayes Classification in Google Earth Engine (GEE)
1. Feature Collection and Labeling

Create a `FeatureCollection` to represent your area of interest, specifically areas containing "log piles." This collection carries out the supervised learning by providingg labeled examples that the classifier uses to learn the characteristics of different classes. Each feature within your collection is labeled according to its class (e.g., log piles are labeled with a class identifier), enabling the classifier to distinguish between the features you're interested in and the background.

2. Import NAIP Imagery

NAIP (National Agriculture Imagery Program) imagery has been selected for its high-resolution and multispectral capabilities, providing detailed visual and near-infrared (NIR) information. This imagery is particularly useful for identifying detailed features on the Earth's surface, making it an excellent choice for tasks requiring fine spatial resolution, such as identifying small or dispersed features like log piles.

3.Image Preprocessing and Band Selection

Filter the NAIP imagery based on geographic bounds and date range, ensuring that the analysis focuses on relevant and timely data for your area of interest. By selecting specific bands ('R', 'G', 'B', 'N'), you tailor the input data to include both visual and NIR information, which is essential for distinguishing different materials and conditions (e.g., vegetation vs. non-vegetation, wet vs. dry materials).

4. Training Data Preparation

The training data is prepared by sampling the NAIP imagery at the locations of your labeled features. This step extracts the spectral information from the selected bands at each labeled location, creating a dataset that associates this spectral information with the known class labels. This dataset forms the basis of the training phase, where the classifier learns the relationship between spectral signatures and class labels.

5. Naive Bayes Classification

You've employed the Naive Bayes classifier, a probabilistic model that assumes independence between the features (in this case, the spectral bands). It works by calculating the probability of each pixel belonging to a given class based on the spectral information and the patterns learned during training. The pixel is then classified into the class with the highest probability.

6. Result Visualization

Finally, the classified image is visualized on the map, with pixels colored according to their assigned class. This visualization helps in assessing the classifier's performance and understanding the spatial distribution of the identified features (log piles) within the imagery.


## Visualizations

We've collected visualizations in the slide presentation. Below are a few visualizations of our main methods:

![OpenStreetMap](https://github.com/CU-ESIIL/FCC24_Group_4/assets/111799296/639b8bd9-8bb1-4a16-ab20-d2dabd2047ea)
Image 1: Contributing sawmill locations in Colorado and Wyoming to Open Street Map. 

![SamAutomaticMaskGenerator](https://github.com/CU-ESIIL/FCC24_Group_4/assets/111799296/c2300a74-73ba-42a0-b734-c7a72d858790)
Image 2: Raw satellite imagery and classification created by SamAutomaticMaskGenerator.

![GoogleEarthEngineClassification](https://github.com/CU-ESIIL/FCC24_Group_4/assets/111799296/f59e5a09-1439-43a4-9d24-7f6324cc5e7d)
Image 3: Classification of logpiles in Google Earth Engine. 

![NaiveBayes](https://github.com/CU-ESIIL/FCC24_Group_4/assets/111799296/8aa7788f-334d-4995-8f4c-26c022ae472a)
Image 4: Example of feature collection based on NAIP in Naïve Bayes. 


## Conclusions

We have a map of confirmed saw mills that could possibly be monitored using remote sensing data. 
Segmentation of key state variables (area covered by logs, wood products, and sawdust) seems possible, but additional work would be needed to generate reliable estimates. 
Mill detection and monitoring may be an underutilized tool that could support applications related to natural climate solutions, natural resource management, and finance. 


# Project methods overview

## Data Sources
List and describe data sources used, including links to cloud-optimized sources. Highlight permissions and compliance with data ownership guidelines.

## Data Processing Steps
Describe data processing steps taken, the order of scripts, etc.

## Data Analysis
Describe steps taken to analyze data and resulting files in team data store file structure.

### segment_geospatial
Using the samgeo package in Python ((https://samgeo.gishub.org/) we tested three methods for detection of log piles. We envision this to be a quick way to distinguish area of log piles at a sawmill, potentially serving as a metric of production. We tested these methods on one site.

We first tested text prompting, which ended up being our best performing method. Using the code provided on the package website (https://samgeo.gishub.org/examples/text_prompts/), we entered the phrase "find stacks of lumber or stacks of logs". The center of the sawmill (coordinates on OSM) were used as the center of the plot and area of interest (AOI) was bounded by the min/max long/lat of the sawmill area. The code exports a tif, which can then be viewed in QGIS or another GIS software. Areas identified as log piles are white pixels while the background is black. If someone was interested in finding or tracking the area of log piles, you would find the area of one pixel then find the number of pixels coded as white

We then tested input prompting, which entailed dropping a point on log piles and dropping points on the background to differentiate. We followed the code provided on the package website (https://samgeo.gishub.org/examples/input_prompts/). This method highlighted the majority of the the sawmill, so it would not be useful for identifying log piles.

Finally we tested the automatic mask generator (https://samgeo.gishub.org/examples/automatic_mask_generator/) which distinguished all the unique options in the AOI. This performed pretty well, but did not pick up as many log piles as the text prompting. 

## Visualizations
Describe visualizations created and any specialized techniques or libraries that users should be aware of.

## Conclusions
Summary of the full workflow and its outcomes. Reflect on the methods used.

## References
Citations of tools, data sources, and other references used.

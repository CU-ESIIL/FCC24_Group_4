# Team 4: 4est

Welcome to the repository for team 4, **4est**, part of ESIIL and Earth Lab's Forest Carbon Codefest. This repository is the central hub for our team, encompassing our project overview, team member information, codebase, and more.

## Our Project
Our project aims to answer the question: where are sawmills in Colorado and Wyoming? Addressing this question had four components: 1) identify the locations of known sawmills in Colorado and Wyoming by integrating and verifying different existing datasets, 2) add the sawmills to [Open Street Map (OSM)](https://taginfo.openstreetmap.org/tags/craft=sawmill#map) for public access, and c) test different machine learning algorithms' abilities to detect sawmills, and d) identify fire disturbance in areas of sawmill reachability. 
## Documentation
- Access detailed documentation on our [GitHub Pages site](https://cu-esiil.github.io/FCC24_Group_4/).


## Group Members
- Member 1: Elizabeth Buhr is a field manager and junior programmer in the Forest Futures Lab at Cary Institute of Ecosystem Studies. Her work focuses on post-fire forest regeneration in the boreal region of Interior Alaska.
- Member 2: Max Joseph is a data scientist at Planet Labs who estimates forest structure with remote sensing and machine learning. 
- Member 3: Hutch Tyree is a masters student at Umass Amherst doing remote sensing. His research focuses on land use land change classification and multisensor fusion for classifying cropland from forested land. 
- Member 4: Kit Lewers is PhD Student in Information Science and Interdisciplinary Quantitative Biology at University of Colorado Boulder. Her research focuses on how information overload impacts institutions grounded in big data and the affects of disciplinary silos on open science and collaboration.
- Member 5: Hilary Brumberg is a graduate student at the University of Colorado Boulder. She researches tropical forest restoration and conservation, focusing on spatial planning, policy and funding mechanisms. 

## Code Repository Structure
- **Data Processing**: "OSM points.ipynb" searches the Open Street Maps (OSM) database for entries matching "craft=sawmill" or "industrial=sawmill" in Colorado and Wyoming.
- **Analysis Code**: Scripts for data analysis, statistical modeling, etc.
- **Visualization**: Code for creating figures, charts, and interactive visualizations.

## Meeting Notes and Agendas

Day 1: March 12, 2024 - CU Boulder
- First, we all introducted ourselves, shared why we were excited to participate in the Codefest, and established team norms.
- Then we brainstormed main different directions for our project.
- We settled on a project with four main goals: 1) identify the locations of known sawmills in Colorado and Wyoming by integrating and verifying different existing datasets, 2) add the sawmills to Open Street Map (OSM) for public access, and c) test different machine learning algorithms' abilities to detect sawmills, and d) identify fire disturbance in areas of sawmill reachability. The first two goals were our targets, and the latter two were our stretch goals.

Day 2: March 13, 2024 - CU Boulder
- We found sawmills that were unmapped on Open Street Map (OSM) and added them to OSM. We used the samgeo package in Python to test different methods (text prompts, input prompts, and automatic mask generator) of identifying wood piles.

Day 3: March 14, 2024 - CU Boulder
- We finalized the project repo and presentation.

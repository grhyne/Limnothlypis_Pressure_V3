# Swainson's Warbler Barometric Geolocator Analysis

Here we analyzed geolocator data with [GeoPressureR](https://raphaelnussbaumer.com/GeoPressureR/) from barometric geolocators (BARP50Z11-7, Migrate Technology) deployed on Swainson's Warblers (Limnothlypis swainsonii) across their breeding range in 2021. Analysis pipeline is described in the [GeoPressureManual](https://raphaelnussbaumer.com/GeoPressureManual). 

We implemented the [Github repository template](https://docs.github.com/articles/creating-a-repository-from-a-template/) with adjustments for our own data. We use only pressure data (no light data), so original light analysis files in the GeoPressureTemplate have been removed. Main components:

	- config.yml file contains the parameters for each tag
	- Raw and labeled data (from TRAINSET)
	- Analysis R files including (1) Labeling, (2) Wind data, and (3) GeoPressureR
	- Final .r objects with trajectories and likelihoods





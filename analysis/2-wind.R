## 2-wind
# Obtaining wind data and generating our movement model

#Set working directory
setwd("C:/Users/Garrett Rhyne/Documents/GitHub/Limnothlypis_Pressure_V3")
id <- "CB627"

#Set Library
library(GeoPressureR)
library(job)

# Must set your unique key and user from Climate Copernicus
Sys.setenv(cds_key = "162f79de-0442-42b9-abed-8ad75f09f17d")
Sys.setenv(cds_user = "151327")

# Create your tags and map extents
tag <- tag_create(
  id = config::get("id", id),
  crop_start = config::get("crop_start", id),
  crop_end = config::get("crop_end", id)
) |>
  tag_label(quiet = TRUE)

tag <- tag_set_map(tag,
                   extent = config::get("extent", id),
                   scale = 1,
                   known = config::get("known", id),
                   include_min_duration = 0
) |>
  geopressure_map(max_sample = 250)

#Acquire wind data
job({
  tag_download_wind(tag)
})

# Define our Movement Model
graph <- graph_create(
  tag,
  thr_likelihood = config::get("thr_likelihood", id),
  thr_gs = config::get("thr_gs", id)
)

#Add wind
graph <- graph_add_wind(
  graph,
  pressure = tag$pressure,
  thr_as = config::get("thr_as", id)
)

graph <- graph_set_movement(graph,
                            bird = bird_create(config::get("scientific_name", id)),
                            low_speed_fix = config::get("movement_low_speed_fix", id)
)

plot_graph_movement(graph)

















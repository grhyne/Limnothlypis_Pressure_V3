#1-label

#Set working directory to your R Project root
#setwd("C:/Users/Garrett Rhyne/Documents/GitHub/Limnothlypis_Pressure_V3")
# getwd()

#Import necessary packages
#install.packages("devtools")
#devtools::install_github("Rafnuss/GeoPressureR")
library(GeoPressureR)
library(ggplot2)

###IMPORTANT: Edit your "config.yml" file so that each tag has the appropriate
# metadata assigned prior to running this code. It is where this file will be obtaining
# configure information

#Tag you want to work with
id <- "CB594"
tag <- tag_create(id)
plot(tag, type = "pressure")

# Check the config is correct
stopifnot(id == config::get("id", config = id))

# Check the dates are cropped correctly (indicated in red)
tag_no_crop <- tag_create(config::get("id", id))

plot(tag_no_crop, type = "pressure", plot_plotly = F) +
  geom_vline(
    xintercept = c(
      as.POSIXct(config::get("crop_start", id)),
      as.POSIXct(config::get("crop_end", id))
    ),
    color = "red", lwd = 1
  )

# Create a tag with a cropped date
tag <- tag_create(config::get("id", id),
                  crop_start = config::get("crop_start", id),
                  crop_end = config::get("crop_end", id),
                  light_file = NA)

# Create a csv file to label your data in TRAINSET
tag_label_write(tag)

# Open csv and edit on https://trainset.raphaelnussbaumer.com/. All labeling should
# follow the GeoPressureManual instructions

# Labelling checks
# Check 1 - Identifies stationary periods and flights that are abnormally short, or
# will stop if data is labelled incorrectly
tag <- tag_label(tag)

# Check 2 - Ensures all stationary periods are >12 datapoints long, and pressure values
# are normal
plot(tag, type = "pressure")

# PressurePaths
# This creates a coarse map of each stationary location purely based on pressure
tag <- tag_set_map(tag,
                   extent = config::get("extent", id),
                   scale = 5,
                   known = config::get("known", id),
                   include_min_duration = config::get("include_min_duration", id)) |>
  geopressure_map()

# Faster/more efficient way to label IMO -° directly use geopressureviz without pressurepath and query the pressure on the map directly
geopressureviz(tag)

# When closing geopressureviz, you get back the path drawn with `geopressureviz_path`
plot_path(geopressureviz_path)

pressurepath <- pressurepath_create(tag, path = geopressureviz_path)

# Check 3 -
plot_pressurepath(pressurepath)

# Check 4 - Histogram of error distributions
plot_pressurepath(pressurepath, type = "histogram")

# Check with GeoPressureViz, however, remember that this is preliminary pressure maps
# that will be adjusted with our movement models!
geopressureviz(
  tag,
  path = pressurepath
)













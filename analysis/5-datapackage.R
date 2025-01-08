library(GeoLocatoR)

## Publish Data Pacakge
# See https://raphaelnussbaumer.com/GeoLocatoR/articles/create-from-geopressuretemplate.html

# Create the datapackage
pkg <- create_gldp_geopressuretemplate(".")

# Modify metadata
pkg$title <- "GeoLocator Data Package: Swainson's Warbler"
# pkg$embargo <- "2030-01-01"
pkg$keywords <- c("Swainson's Warbler", "Neotropical Migrant", "multi-sensor geolocator")
# Add DOI of the datapackage if already available or reserve it https://help.zenodo.org/docs/deposit/describe-records/reserve-doi/#reserve-doi
pkg$id <- "https://doi.org/"
# Provide the recommended citation for the package
pkg$citation <- " Rhyne, G. (2025). GeoLocator Data Package: Swainson's Warbler [Data set]. Zenodo. https://doi.org/10.5281/zenodo.14606625"
# Funding sources
 pkg$grants <- c("Louisiana State University")
# Identifiers of resources related to the package (e.g. papers, project pages, derived datasets, APIs, etc.).
pkg$relatedIdentifiers <- list(
  list(
    relationType="IsPartOf",
    relatedIdentifier="10.5281/zenodo.14606625",
    relatedIdentifierType="DOI"
  ),
  list(
    relationType="IsSupplementTo",
    relatedIdentifier="",
    relatedIdentifierType="DOI"
  )
)
# List of references related to the package
#pkg$references <- NULL
# Add reference_location. Computed automatically when adding data
# pkg$reference_location <- list(lat = 45.211,  lon = 34.25)

# Add data
pkg <- pkg %>% add_gldp_geopressuretemplate(directory = ".", from = "interim")
# print(pkg)

# Check package
check_gldp(pkg)

# Write datapackage
dir.create("data/datapackage", showWarnings = FALSE)
write_package(pkg, "data/datapackage/")

# Upload on Zenodo
# https://zenodo.org/uploads/new
# Use the information in datapackage.json to fill the zenodo form.

# See https://raphaelnussbaumer.com/GeoPressureManual/geopressuretemplate-workflow.html

library(GeoPressureR)

# Run workflow step-by-step for a single tag
id <- "18LX" # Run a single tag
geopressuretemplate_config(id)
tag <- geopressuretemplate_tag(id)
graph <- geopressuretemplate_graph(id)
geopressuretemplate_pressurepath(id)


## Run workflow for all tags
list_id <- tail(names(yaml::yaml.load_file("config.yml", eval.expr = FALSE)), -1)
id = "CB619"

for (id in list_id){
  cli::cli_h1("Run tag for {id}")
  geopressuretemplate_tag(id)
}


# Run graph
for (id in list_id){
  cli::cli_h1("Run graph for {id}")
  geopressuretemplate_graph(id)
}

# Manual checking of coherence
# "CB594", "CB596", "CB598", "CB599", "CB601", "CB608", "CB611", "CB616", "CB619", "CB620", "CB621", "CB623", "CB624", "CB627"
# geopressureviz(id)


# Run pressurepath
for (id in c("CB596", "CB598", "CB599", "CB601", "CB608", "CB611", "CB616", "CB619", "CB620", "CB621", "CB623", "CB624", "CB627")){
  cli::cli_h1("Run pressurepath for {id}")
  geopressuretemplate_pressurepath(id)
}


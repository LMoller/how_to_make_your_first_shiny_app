library(shiny)
library(tidycensus)
library(tidyverse)
options(tigris_use_cache = TRUE)
library(readr)
library(mapview)

census_api_key("a0f506f2d91c49bc38e968bf9340c49020868647")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # Load data from Census
    boulder_tract <- get_acs(state = "CO", county = "Boulder", variables = "B01003_001", geography = "tract", geometry = TRUE)
    
    # Load Low Response Numbers
    lrr_boulder <- read_csv("boulder_LR_census.csv")
    
    # remove leading zero from GEOID in boulder df
    boulder_tract$GEOID <-  as.numeric(str_remove(boulder_tract$GEOID, "^0+"))
    
    # Join dataframes together
    boulder <- inner_join(boulder_tract, lrr_boulder, by = c("GEOID" = "GIDTR"))
    
    # map with mapview
    m <- mapview(boulder, zcol = "Low_Response_Score", legend = TRUE)
    
    # Create map
    output$mapplot <- renderLeaflet({
        m@map
    })

})

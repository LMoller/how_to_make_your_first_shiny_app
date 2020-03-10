library(shiny)
library(tidycensus)
library(tidyverse)
library(readr)
library(mapview)

options(tigris_use_cache = TRUE)

census_api_key("a0f506f2d91c49bc38e968bf9340c49020868647")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # ## Load data from Census - need to run this for the lat/long coordinates to compare with Low Response downloads
    # 
    # # Tract level
    # boulder_tract <- get_acs(state = "CO", county = "Boulder", variables = "B01003_001", geography = "tract", geometry = TRUE)
    # 
    # # Load Low Response Numbers at census tract level. Download from: https://www.census.gov/topics/research/guidance/planning-databases.html
    # lrr_boulder_CT <- read_csv("boulder_LR_census.csv")
    # 
    # # remove leading zero from GEOID in boulder df
    # boulder_tract$GEOID <-  as.numeric(str_remove(boulder_tract$GEOID, "^0+"))
    # 
    # # Join dataframes together
    # boulder_CT <- inner_join(boulder_tract, lrr_boulder_CT, by = c("GEOID" = "GIDTR"))
    # 
    # # map with mapview
    # m <- mapview(boulder_CT, zcol = "Low_Response_Score", legend = TRUE)
    
    ###############################
    
    ## Load data from Census - BLOCK GROUP - need to run this for the lat/long coordinates to compare with Low Response downloads

    # Block Group level
    boulder_blockgroup <- get_acs(state = "CO", county = "Boulder", variables = "B01003_001", geography = "block group", geometry = TRUE)

    # Load Low Response Numbers at Block Group level. Download from: https://www.census.gov/topics/research/guidance/planning-databases.html
    lrr_boulder_BG <- read_csv("boulder_county_BG.csv")

    # remove leading zero from GEOID in boulder df
    boulder_blockgroup$GEOID <-  as.numeric(str_remove(boulder_blockgroup$GEOID, "^0+"))

    # Join dataframes together
    boulder_BG <- inner_join(boulder_blockgroup, lrr_boulder_BG, by = c("GEOID" = "GIDBG"))

    # map with mapview
    m <- mapview(boulder_BG, zcol = "Low_Response_Score", legend = TRUE)
    
    # Create map
    output$mapplot <- renderLeaflet({
        m@map
    })

})

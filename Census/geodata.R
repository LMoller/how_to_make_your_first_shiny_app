library(tidycensus)
library(tidyverse)
options(tigris_use_cache = TRUE)
library(readr)
library(mapview)

# Load data from Census
boulder_tract <- get_acs(state = "CO", county = "Boulder", variables = "B01003_001", geography = "tract", geometry = TRUE)

# Load Low Response Numbers
lrr_boulder <- read_csv("boulder_LR_census.csv")

# remove leading zero from GEOID in boulder df
boulder_tract$GEOID <-  as.numeric(str_remove(boulder_tract$GEOID, "^0+"))

# Join dataframes together
boulder <- inner_join(boulder_tract, lrr_boulder, by = c("GEOID" = "GIDTR"))

# map with mapview
mapview(boulder, zcol = "Low_Response_Score", legend = TRUE)

##################################################################################################
# Resources and other ways of mapping

#https://juliasilge.com/blog/using-tidycensus/
#https://walkerke.github.io/tidycensus/articles/spatial-data.html#detailed-shoreline-mapping-with-tidycensus
# 
# # try mapping with geom_sf - good, but I would like streets, etc. Can use faceting easily
# boulder %>%
#   ggplot(aes(fill = Low_Response_Score)) + 
#   geom_sf(color = NA) + 
#   #coord_sf(crs = 26911) + 
#   scale_fill_viridis_c(option = "magma") 
# 
# 
# 
# 
# library(leaflet)
# library(stringr)
# library(sf)
# 
# pal <- colorQuantile(palette = "viridis", domain = boulder$Low_Response_Score, n = 10)
# 
# boulder %>%
#   st_transform(crs = "+init=epsg:4326") %>%
#   leaflet(width = "100%") %>%
#   addProviderTiles(provider = "CartoDB.Positron") %>%
#   addPolygons(popup = ~ str_extract(NAME, "^([^,]*)"),
#               stroke = FALSE,
#               smoothFactor = 0,
#               fillOpacity = 0.7,
#               color = ~ pal(Low_Response_Score)) %>%
#   addLegend("bottomright", 
#             pal = pal, 
#             values = ~ Low_Response_Score,
#             title = "Low Response Score",
#             opacity = 1)

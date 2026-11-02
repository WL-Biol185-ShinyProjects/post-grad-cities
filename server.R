#Hook up output bindings to inputs

library(shiny)
library(ggplot2)
library(tidyverse)
library(sf)
library(tigris)
library(leaflet)
library(dplyr)

options(tigris_use_cache = TRUE)
city_coordinates_df <- readRDS("city_coordinates_df.rds")

leaflet(data = city_coordinates_df) %>% 
  addProviderTiles("OpenStreetMap.Mapnik") %>% 
  setView(lng = -95.7129, lat = 37.0902, zoom = 4) %>%   
addPolygons(
  data = city_coordinates_df,
  fillColor = "#3182bd",
  weight = 1,
  opacity = 1,
  color = "white",
  fillOpacity = 0.4,
  highlightOptions = highlightOptions(
    weight = 2,
    color = "#222",
    fillOpacity = 0.7,
    bringToFront = TRUE
  ),
  label = ~name
) %>% 
  addMarkers(
    data = city_coordinates_df,
    lng = ~LONGITUDE,   # Replace with your actual longitude column name if different
    lat = ~LATITUDE,    # Replace with actual latitude column name if different
    popup = ~City_State # Shows "City, State" text when clicking marker
  )
  
  

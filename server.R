#Hook up output bindings to inputs

library(shiny)
library(ggplot2)
library(tidyverse)
library(sf)
library(tigris)
library(leaflet)
library(dplyr)

filtered_cities_df <- read.csv("cleaned_us_cities.csv")

leaflet() %>% 
  addProviderTiles("OpenStreetMap.Mapnik") %>% 
  setView(lng = -95.7129, lat = 37.0902, zoom = 4)  

# Add State Boundaries
addPolygons(
  data = us_states,
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
    data = cities_df,
    lng = ~LONGITUDE,   # Replace with your actual longitude column name if different
    lat = ~LATITUDE,    # Replace with your actual latitude column name if different
    popup = ~City_State # Shows your "City, State" text when clicking a marker
  )
  
  

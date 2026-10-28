#Hook up output bindings to inputs

library(shiny)
library(ggplot2)
library(tidyverse)
library(sf)
library(tigris)
library(leaflet)


library(leaflet)

leaflet() %>% addTiles()
leaflet() %>% setView(lng = -95.7129, lat = 37.0902, zoom = 4) %>% 
  addProviderTiles("Esri.WorldGrayCanvas")%>%
  
  
cities_df <- read.csv("us_cities.csv")


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
) 
  
  

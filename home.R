
library(shiny)
library(ggplot2)
library(sf)
library(leaflet)
library(tidyverse)


city_master <- read.csv("city_master.csv")

# Import Home page server function

# Create an interactive map from city_master dataframe (including all measured variables)
server <- function(input, output) {
  homeServer("home", city_master)
  output$cityMap <- renderleaflet({
      leaflet(city_master) %>% 
      setView(lng = -95.7129, lat = 37.0902, zoom = 4) %>%
      addLegend(
        cityMap, 
        position = "topright"
      )
      addProviderTiles("OpenStreetMap.Mapnik") %>% 
      
      addCircleMarkers(
        fillColor = 
        "Blues", 
        domain = city_master$Alumni_Count,
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
    
  })
  
}




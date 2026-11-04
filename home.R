
library(shiny)
library(ggplot2)
library(sf)
library(leaflet)


city_master <- read.csv("city_master.csv")


# Create an interactive map from city_master dataframe (including all measured variables)
function(input, output) {
  
  output$cityMap <- renderleaflet({
    
    city_master %>%
      leaflet(city_master) %>% 
      setView(lng = -95.7129, lat = 37.0902, zoom = 4) %>%  
      addProviderTiles("OpenStreetMap.Mapnik") %>% 
      addPolygons(
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


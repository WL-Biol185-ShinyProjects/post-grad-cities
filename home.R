
library(shiny)
library(ggplot2)
library(sf)
library(leaflet)
library(tidyverse)

home_ui <- function() {
  Fluidpage(
    h2("Home"),
    leafletOutput("map", height = 600)
    )
}


city_master <- read.csv("city_master.csv")

# Import Home page server function

# Create an interactive map from city_master dataframe (including all measured variables)
home_server <- function(input, output) {
  output$cityMap <- renderleaflet({
      leaflet(city_master) %>% 
      setView(lng = -95.7129, lat = 37.0902, zoom = 4) %>%
    # Create a layout with the map on the left and map controls on the right.
      fluidRow(
        column(
          width = 9, 
          leafletOutput(
            outputID = ns("cityMap"),
            height = "600px"
          )),
# Map controls         
        column(
          width = 3,
          div(
            style = paste0(
              "background-color: #f5f5f5;,
              padding: 25px;,
              border-radius: 15px;"
              ),
            h3("Map Controls"),      # Title inside the box
            selectInput(
              inputId = ns("mapVariable"),
              label = "View by:",
              choices = c(
                "Alumni Concentration" = "Alumni_Count",
                "Monthly Rent" = "Rent_2025",
                "Population" = "pop_2025",
                "Labor Market Tightness" = "Tightness_Index"
                ),
              selected = "Alumni_Count"
            )
          )
        ))
  }
      )
      addLegend(
        position = "topright",
        pal = pal,
        values = values,
        title = legend_title,
        opacity = 0.85,
        labFormat = labelFormat(
          digits = 0,
          big.mark = ","
        ),
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
    
  }
  




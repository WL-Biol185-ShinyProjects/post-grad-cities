
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


titlePanel("Interactive Map")
sidebarLayout(
  sidebarPanel(
    sliderInput(
      inputId = "citySelector",                #here is where you title your input; needs to be unique
      label = "Explore Your Post-Grad City!",       # What you want the people viewing the app to read
      min = min(city_master$Rent..2025),                #Min and max will be established accurately according to the values in the table at that time
      max = max(city_master$Rent..2025),
      value = c(min(city_master$Rent..2025), max(city_master$Rent..2025))                               #We want this to represent the full range of values
    )
  ),
  mainPanel(
    leafletOutput("cityMap")                            #Output names also need to be unique. There's also a text Output, leaflet output, etc.
  )
)





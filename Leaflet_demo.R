
library(leaflet)

leaflet() %>% addTiles()
leaflet() %>% setView(lng = -95.7129, lat = 37.0902, zoom = 4) %>% 
  addProviderTiles("Esri.WorldGrayCanvas")%>%
  
  
cities_df <- read.csv("us_cities.csv")
View(cities_df)

  
  
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



# Positional markers; table that has latitudes, longitudes, and metadata about locations
lex <- data.frame( lat    = c(37.789444 , 37.787673  ,  37.785624  )
                   , lon    = c(-79.441725, -79.443623 , -79.441544  )
                   , place  = c("Lab"     , "Classroom", "Thai food!")
                   , rating = c(7         , 5          , 10          )
                   , stringsAsFactors = FALSE
)

# Data = lexington table; place is coming from my table. 
leaflet(data = lex) %>% 
  setView(lng = -79.442778, lat = 37.783889, zoom = 12) %>%
  addTiles() %>% 
  addMarkers(popup = ~place, clusterOptions = markerClusterOptions())

# Add circle markers; geographic region as a descriptive quantity 
leaflet(data = lex) %>% 
  addTiles() %>% 
  addCircleMarkers(radius = ~rating, label = ~place)


#Add circles: Difference is how they relate screen space to geography of the map 
leaflet(data = lex) %>% 
  addTiles() %>%
  addCircles(radius = ~rating, label = ~place)




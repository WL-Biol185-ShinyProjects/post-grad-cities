
library(shiny)
library(leaflet)
library(shinydashboard)

# Loading data and creating new dataframe that filters columns we need
city_master <- read.csv("city_master.csv")

interactive_map <- city_master[, c("City_State", "Alumni_Count", "pop_2025",     # Keep only columns we will use
                                   "Rent_2025", "Tightness_Index",
                                   "LATITUDE", "LONGITUDE")]

# Create home page layout
homePage <- tabPanel(
  "Home",
  h2("Where Do W&L Alumni Live?"),
  h4("Explore where Washington and Lee alumni have gone since 2016."),
 
# Left side: map
  fluidRow(
    box(
      width = 9,
      leafletOutput("cityMap", height = "600px")
    ),
    
# right side: map legend/controls 
    box(
      width = 3,
      h4("Number of W&L Alumni"),
      h4("Map Controls"),
      selectInput(
        "view_by", 
        "View by:",
      choices = c(
        "Alumni Concentration",
        "Monthly Rent",
        "Population", 
        "Labor Market Tightness")))
 )
)
  
# Create home page server 
home_server <- function(input, output) {
  
  output$cityMap <- renderLeaflet({
    
# Which column and legend title go with the current dropdown choice. 
# Switch(): app uses Alumni_Count if user selects Alumni Concentration option
  col_name <- switch(
    input$view_by,
    "Alumni Concentration" = "Alumni_Count",
    "Monthly Rent" = "Rent_2025",
    "Population" = "pop_2025",
    "Labor Market Tightness" = "Tightness_Index"
    )
  
  # Define legend arguments: get values from selected variable and make color scale
  vals <- city_master[[col_name]]
  pal <- colorNumeric(
    palette = "YlOrRd", 
    domain = vals
  )       
  
  # Scale circle sizes
  radius <- 4 + 16 * sqrt(vals / max(vals, na.rm = TRUE))
  
  # Creating the actual interactive map with markers and a set view
  leaflet(interactive_map) %>%
    addProviderTiles("OpenStreetMap.Mapnik") %>% 
    addCircleMarkers(
        lng = ~LONGITUDE, 
        lat = ~LATITUDE,
        radius = radius,
        fillColor = pal(vals),
        fillOpacity = 0.8,         # Fill opacity helps show colors better   
        popup = ~City_State        # Shows "City, State" text when clicking marker
    ) %>% 
  setView(
    lng = -96, 
    lat = 38, 
    zoom = 4
  ) %>%
  
  # Add map legend
    addLegend(
      position = "topright",
      pal = pal,
      values = vals,
      title = input$view_by,
      opacity = 0.85,
      labFormat = labelFormat(
        digits = 0,
        big.mark = ","
    )
  )
  
  })

}



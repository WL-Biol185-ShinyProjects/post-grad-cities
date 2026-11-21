
library(shiny)
library(leaflet)
library(shinydashboard)

# Loading data and creating new dataframe that filters columns we need
city_master <- read.csv("city_master_done.csv")

interactive_map <- city_master[, c("City_State", "Alumni_Count", "pop_2025",     # Keep only columns we will use
                                   "Rent_2025", "Tightness_Index",
                                   "LATITUDE", "LONGITUDE")]

# Create home page layout
homePage <- tabPanel(
  "Home",
  
# Add the CSS for the banner.
  tags$head(
    # Import font styles
    tags$link(
      rel = "stylesheet",
      href = paste0(
        "https://fonts.googleapis.com/css2?",
        "family=EB+Garamond:wght@400;500;600;700",
        "&family=Inter:wght@400;500;600;700",
        "&display=swap"
      )
    ),
    
# Campus background photo banner 
    tags$style(HTML("
        .campus-banner {
        width: 100%;
        box-sizing: border-box;          /* Include padding in the banner width */
        margin: 0 0 28px;               /* Leave space below the banner */
        background-image: url('background_wlu_pic.png');
        background-size: cover;         /* fill the banner, crop if needed */
        background-position: center;    
        background-repeat: no-repeat;
        height: 320px;                 
        display: flex;
        align-items: center;
        padding: 0 clamp(16px, 4vw, 64px)

/* Make the photo run edge-to-edge. This closes the gap under the navbar. */
        margin: -20px -15px 28px -15px;
        }
      
/* Translucent white title box */
     .banner-text {
        background-color: #FFFFFF;  
        padding: 32px 42px;
        max-width: 810px;              
        width: 100%;                
      }

/* Main title */
      .banner-text h1 {
        font-family: 'EB Garamond', Georgia, serif;
        font-size: 48px;
        font-weight: 600;
        color: #142F56;
        line-height: 1.2;
        margin-top: 0;          
        margin-bottom: 12px;
      }

/* Subtitle */
      .banner-text p {
        font-family: 'Inter', Arial, sans-serif;
        font-size: 17px;
        font-weight: 400;
        line-height: 1.6;
        color: #40556C;
        margin-bottom: 0;
      }
      
/* Map card */
      .map-card {
        background-color: #FFFFFF;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.12);
        padding: 8px;                   
        margin-bottom: 30px;
      }
      .map-card .leaflet-container {        /* Round the corners of the map */
        border-radius: 6px;
        font-family: 'Inter', Arial, sans-serif;
      }

/* Legend box on the map: rounder corners + Inter font. */
      .leaflet .info.legend {
        font-family: 'Inter', Arial, sans-serif;
        border-radius: 6px;
        padding: 10px 12px;
      }
      
/* Map controls card (right-hand panel) */
   .controls-card {
        background-color: #FFFFFF;
        border-radius: 8px 8px 0 0;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.12);
        overflow: visible;               /* clips header to rounded corners */
        margin-bottom: 30px;
      }
/* Map Controls navy header */
      .controls-header {
        background-color: #142F56;
        color: #FFFFFF;
        font-family: 'EB Garamond', Georgia, serif; 
        font-size: 28px;                            
        font-weight: 600;
        margin: 0;                      /* cancel Bootstrap heading margins */
        padding: 14px 24px;
      }

/* White area under the heading that holds the dropdown. */
      .controls-body {
        padding: 20px 24px 12px 24px;
      }
      .controls-body label {            /* the 'View by:' label */
        font-family: 'Inter', Arial, sans-serif;
        font-size: 17px;
        font-weight: 600;
        color: #142F56;
      }
      .controls-body .selectize-input,
      .controls-body select {           /* the dropdown box */
        font-family: 'Inter', Arial, sans-serif;
        font-size: 16px;
        border-radius: 6px;
      }

    "))
  ),

# div(class = "campus-banner") is the 320px photo strip (CSS above)
# div(class = "banner-text") is the translucent white box on top of it
div(
  class = "campus-banner",
  
  div(
    class = "banner-text",
    
    h1("Find Your Post-Grad City"),                                 
    p("Explore where W&L grads have landed since 2016.")  
  )
),
  h2("Where Do Most W&L Alumni Live?"),
  
  p("Choosing where to live after graduation is a big decision. With so many cities offering different career opportunities, costs of living, and lifestyles, it can be difficult to know where to start."),
  
  p("We created this app to help Washington and Lee students explore potential places to live after graduation. Using data on W&L alumni from the classes of 2016–2025, the app highlights where recent graduates have settled and allows users to compare cities based on alumni concentration, monthly rent, population, and labor market conditions."),
  
  p("Our goal is to make the post-grad decision-making process easier by connecting alumni experiences with real-world city data. Whether you are looking for a city with a strong W&L alumni community, affordable housing, or promising career opportunities, this tool can help you find a place that fits your priorities."),
  
  h4("Explore where W&L grads have landed since 2016."),
 
# Left side: map
  fluidRow(
    column(
      width = 9,
      div(
        class = "map-card",
        leafletOutput("cityMap", height = "600px")
      )
    ),
    
# right side: map legend/controls 
    column(
      width = 3,
      div(
        class = "controls-card",
        h3("Map Controls", class = "controls-header"),
        div(
          class = "controls-body",
          selectInput(
            inputId = "view_by",
            label   = "View by:",
            choices = c("Alumni Concentration",
                        "Monthly Rent",
                        "Population",
                        "Labor Market Tightness"),
            width   = "100%"
          )
        )
      )
    ) # Closes right side map legend 
  ) # Closes fluidRow for map on left side
) # Closes tabPanel 


  
# Create home page server 
home_server <- function(input, output) {
  
  output$cityMap <- renderLeaflet({
    req(input$view_by)
    
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
        stroke = FALSE,  # Removes blue rings outside the circle markers
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
        big.mark = ",",
        prefix = "\u2002"   # prefix adds two spaces before each number, giving it room to the right of the tick mark
    )
  )
  
  })

}



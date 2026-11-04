
# Describe layout of the app; user interface

install.packages("bslib")
library(shiny)
library(ggplot2)
library(leaflet)
library(bslib)


fluidPage(
  navbarPage("W&L Post-Grad Cities",
             tabPanel("Home"),                     # Create Home webpage including heat map and questionnaire 
             tabPanel("Dive Into the Data"),
             tabPanel("Resources")
  ),
  

  titlePanel("Interactive Map"),
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
      leafletOutput("post_grad_city_interactive_map")                            #Output names also need to be unique. There's also a text Output, leaflet output, etc.
    )
  )
)



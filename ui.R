
# Describe layout of the app; user interface

library(shiny)
library(ggplot2)
library(leaflet)


fluidPage(
  
  title = "Interactive Map",
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "caratSelector",                #here is where you title your input; needs to be unique
        label = "Explore Your Post-Grad City!",       # What you want the people viewing the app to read
        min = min(diamonds$carat),                #Min and max will be established accurately according to the values in the table at that time
        max = max(diamonds$carat),
        value = c(min(diamonds$carat), max(diamonds$carat))                               #We want this to represent the full range of values
      )
    ),
    mainPanel(
      plotOutput("post_grad_city_interactive_map")                            #Output names also need to be unique. There's also a text Output, leaflet output, etc.
    )
  )
)




# Describe layout of the app; user interface

#install.packages("bslib")
library(shiny)
library(dplyr)
library(ggplot2)
library(leaflet)
library(bslib)

#Add sources to other files to avoid merge conflicts
source("data.R")   # loads data_ui and data_server

fluidPage(
<<<<<<< HEAD
  navbarPage("W&L Post-Grad Cities",
             tabPanel("Home", homeUI("home"),
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
                          leafletOutput("cityMap")                            #Output names also need to be unique. There's also a text Output, leaflet output, etc.
                        )
                      ),
                                           # Create Home webpage including heat map and questionnaire 
             tabPanel("Dive Into the Data"),
             tabPanel("Resources")
  )))
  





source("home.R")
source("question.R")
source("data.R")
source("resources.R")

fluidPage(
  navbarPage(
    title = "W&L Post-Grad Cities",
    
             homePage,
             questionPage,
             dataPage,
             resourcesPage
  )
  title = "W&L Alumni Cities",
  data_ui("data")
)
# fluidPage(
#   navbarPage("W&L Post-Grad Cities",
#              tabPanel("Home",
#                       titlePanel("Interactive Map"),
#                       sidebarLayout(
#                         sidebarPanel(
#                           sliderInput(
#                             inputId = "citySelector",                #here is where you title your input; needs to be unique
#                             label = "Explore Your Post-Grad City!",       # What you want the people viewing the app to read
#                             min = min(city_master$Rent..2025),                #Min and max will be established accurately according to the values in the table at that time
#                             max = max(city_master$Rent..2025),
#                             value = c(min(city_master$Rent..2025), max(city_master$Rent..2025))                               #We want this to represent the full range of values
#                           )
#                         ),
#                         mainPanel(
#                           leafletOutput("cityMap")                            #Output names also need to be unique. There's also a text Output, leaflet output, etc.
#                         )
#                       ),
#                                            # Create Home webpage including heat map and questionnaire 
#              tabPanel("Dive Into the Data"),
#              tabPanel("Resources")
#   )))
#   
# 
# 
# 
# 
# 
# source("home.R")
# source("question.R")
# source("data.R")
# source("resources.R")
# 
# fluidPage(
#   navbarPage(
#     title = "W&L Post-Grad Cities",
#     
#              homePage,
#              questionPage,
#              dataPage,
#              resourcesPage
#   )
# )
# 

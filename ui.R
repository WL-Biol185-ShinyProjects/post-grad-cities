
# Describe layout of the app; user interface

#install.packages("bslib")
library(shiny)
library(dplyr)
library(ggplot2)
library(leaflet)
library(bslib)

#Add sources to other files to avoid merge conflicts
source("home.R")
source("question.R")
source("data.R")
source("resources.R")


fluidPage(
  navbarPage("W&L Post-Grad Cities",
             tabPanel("Home", home_ui("home")),
                      titlePanel("Interactive Map"),
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput(
                            inputId = "citySelector",                #here is where you title your input; needs to be unique
                            label = "Explore Your Post-Grad City!",       # What you want the people viewing the app to read
                            min = min(city_master$Alumni_Count),                #Min and max will be established accurately according to the values in the table at that time
                            max = max(city_master$Alumni_Count),
                            value = c(min(city_master$Alumni_Count), max(city_master$Alumni_Count))                               #We want this to represent the full range of values
                          )
                        ),
                        mainPanel(
                          leafletOutput("cityMap")                            #Output names also need to be unique. There's also a text Output, leaflet output, etc.
                        )
                      ),
             tabPanel("Dive Into the Data", data_ui()),
             tabPanel("Resources")
  )))

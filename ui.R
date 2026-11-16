
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

  navbarPage(
    title = "W&L Post-Grad Cities",
             homePage,
             dataPage,
             questionPage
  )


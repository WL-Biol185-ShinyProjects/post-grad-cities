
# Describe layout of the app; user interface

# Packages 
library(shiny)
library(dplyr)
library(ggplot2)
library(leaflet)
library(bslib)
library(tidyr)

#Add sources to other files to avoid merge conflicts
source("home.R")
source("question.R")
source("data.R")
source("about_us.R")

# Navigation bar styling
navbar_css <- "
/* Style the whole navigation bar. Both class names refer to the same bar */
    .navbar.navbar-default {
      background: #142F56;   
      border: 0;             
      border-radius: 0;      
      margin-bottom: 0;     
    }
/* Style the app name logo in the top left corner */
    .navbar-default .navbar-brand {
      color: white;
      font: 600 26px/20px 'EB Garamond', Georgia, serif;
    }
/* Keep the navbar title and tab links white on hover and focus */
    .navbar-default .navbar-brand:hover,
    .navbar-default .navbar-brand:focus,
    .navbar-default .navbar-nav > li > a,
    .navbar-default .navbar-nav > li > a:hover,
    .navbar-default .navbar-nav > li > a:focus {
      color: white;
    }
/* Underline the selected tab in white over the navy bar */
    .navbar-default .navbar-nav > .active > a,
    .navbar-default .navbar-nav > .active > a:hover,
    .navbar-default .navbar-nav > .active > a:focus {
      color: white;
      background: transparent;
      text-decoration: underline;
      text-underline-offset: 8px;
    }
/* Align the tabs right on screens */
    @media (min-width: 768px) {
      .navbar-default .navbar-nav {
        float: right;
      }
    }
 "
  
# App Layout
  tagList(
  tags$head(tags$style(HTML(navbar_css))),    # Apply the CSS across all tabs.
  
# Create top bar and connect tabs to their pages
  navbarPage(
    title = "Washington and Lee | Post-Grad Cities",
    collapsible = TRUE,       # places tabs inside a menu button on narrow screens
             homePage,
             dataPage,
             questionPage,
             about_usPage
  )
)



#Hook up output bindings to inputs

library(shiny)
library(dplyr)
library(ggplot2)

function(input, output) {
  home_server("home")
  data_server(input, output)
}
#Hook up output bindings to inputs

library(shiny)
library(dplyr)
library(ggplot2)

function(input, output) {
  home_server(input, output)
  data_server(input, output)
}
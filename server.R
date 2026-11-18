#Hook up output bindings to inputs

library(shiny)
library(dplyr)
library(ggplot2)

city_master <- read.csv("city_master_done.csv")

function(input, output) {
  home_server(input, output)
  data_server(input, output)
  question_server(input, output)
}
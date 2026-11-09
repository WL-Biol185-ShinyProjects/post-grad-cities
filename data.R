data_ui <- function(id) {
  ns <- NS(id)
  fluidPage(
    h2("Explore the Data"),
    plotOutput(ns("top_cities")),
    plotOutput(ns("rent_vs_alumni"))
  )
}

data_server <- function(id) {
  master_city <- read.csv("city_master.csv")
  
  moduleServer(id, function(input, output, session) {
    
    # Which cities have the most alumni
    output$top_cities <- renderPlot({
      master_city %>%
        slice_max(Alumni_Count, n = 10) %>%
        ggplot(aes(x = reorder(City_State, Alumni_Count), y = Alumni_Count)) +
        geom_col(fill = "#0B3D91") +
        coord_flip() +
        labs(title = "Top 10 cities for W&L alumni", x = NULL, y = "Number of Alumni") +
        theme_minimal()
    })
    
    # Rent vs. alumni
    output$rent_vs_alumni <- renderPlot({
      ggplot(master_city, aes(x = Rent_2025, y = Alumni_Count)) +
        geom_point(color = "#0B3D91", size = 3) +
        geom_text(aes(label = City_State), vjust = -0.8, size = 3,
                  check_overlap = TRUE) +
        labs(title = "Rent vs. number of alumni",
             x = "Average monthly rent ($)", y = "Number of Alumni") +
        theme_minimal()
    })
  })
}
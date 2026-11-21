# Layout for the data exploration page
dataPage <- tabPanel(
  "Dive Into the Data",
  
  fluidPage(
    
    # Page heading
    div(
      style = "text-align: center; padding: 25px 0 15px 0;",
      h1("Explore the Data",
         style = "color: #0B3D91; font-weight: bold;"),
      p("Discover where W&L young alumni are living, working, and building communities.",
        style = "font-size: 16px; color: #666666;")
    ),
    
    # First row of graphs
    fluidRow(
      
      column(
        width = 6,
        div(
          style = "background-color: white; padding: 20px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.10); margin-bottom: 25px;",
          plotOutput("top_cities", height = "350px")
        )
      ),
      
      column(
        width = 6,
        div(
          style = "background-color: white; padding: 20px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.10); margin-bottom: 25px;",
          plotOutput("rent_vs_alumni", height = "350px")
        )
      )
    ),
    
    # Second row of graphs
    fluidRow(
      
      column(
        width = 12,
        div(
          style = "background-color: white; padding: 20px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.10); margin-bottom: 25px;",
          plotOutput("industry_breakdown", height = "450px")
        )
      )
    ),
    
    # Third row of graphs
    fluidRow(
      
      column(
        width = 12,
        div(
          style = "background-color: white; padding: 20px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.10); margin-bottom: 25px;",
          plotOutput("major_plot", height = "750px")
        )
      )
    )
  )
)

data_server <- function(input, output) {
  city_master <- read.csv("city_master_done.csv")
    
    # Which cities have the most alumni
    output$top_cities <- renderPlot({
      city_master %>%
        slice_max(Alumni_Count, n = 10) %>%
        ggplot(aes(x = reorder(City_State, Alumni_Count), y = Alumni_Count)) +
        geom_col(fill = "#0B3D91") +
        coord_flip() +
        labs(title = "Top 10 cities for W&L young alumni", x = NULL, y = "Number of Young Alumni") +
        theme_minimal() +
        theme(
          plot.title = element_text(
            color = "#0B3D91",
            face = "bold",
            size = 16
          ),
          axis.title = element_text(size = 11),
          axis.text = element_text(color = "#444444"),
          panel.grid.minor = element_blank()
        )
    })
    
    # Rent vs. alumni
    output$rent_vs_alumni <- renderPlot({
      ggplot(city_master, aes(x = Rent_2025, y = Alumni_Count)) +
        geom_point(color = "#0B3D91", size = 3) +
        geom_text(aes(label = City_State), vjust = -0.8, size = 3,
                  check_overlap = TRUE) +
        labs(title = "Rent vs. number of alumni",
             x = "Average monthly rent ($)", y = "Number of Alumni") +
        theme_minimal() +
        theme(
          plot.title = element_text(
            color = "#0B3D91",
            face = "bold",
            size = 16
          ),
          axis.title = element_text(size = 11),
          axis.text = element_text(color = "#444444"),
          panel.grid.minor = element_blank()
        )
    })
    
    # Industry breakdown by city
    output$industry_breakdown <- renderPlot({
      city_master %>%
        slice_max(Alumni_Count, n = 10) %>%
        select(City_State, Alumni_Count, starts_with("Industry_")) %>%
        pivot_longer(cols = starts_with("Industry_"),
                     names_to = "Industry",
                     values_to = "Count") %>%
        mutate(
          Industry = gsub("Industry_", "", Industry),
          Industry = gsub("_", " ", Industry),
          Percent = (Count / Alumni_Count) * 100
        ) %>%
        ggplot(aes(x = reorder(City_State, Alumni_Count),
                   y = Percent, fill = Industry)) +
        geom_col() +
        coord_flip() +
        labs(title = "Industry Breakdown of W&L Alumni by City",
             x = NULL, y = "Percentage of Alumni", fill = "Industry") +
        theme_minimal() +
        theme(
          plot.title = element_text(
            color = "#0B3D91",
            face = "bold",
            size = 16
          ),
          axis.title = element_text(size = 11),
          axis.text = element_text(color = "#444444"),
          panel.grid.minor = element_blank()
        )
    })
    
    # Major vs. city heatmap
    output$major_plot <- renderPlot({
      city_master %>%
        select(City_State, Alumni_Count, starts_with("Major_")) %>%
        pivot_longer(cols = starts_with("Major_"),
                     names_to = "Major",
                     values_to = "Count") %>%
        mutate(
          Major = gsub("Major_", "", Major),
          Percent = (Count / Alumni_Count) * 100
        ) %>%
        ggplot(aes(x = Major, y = City_State, fill = Percent)) +
        geom_tile(color = "white") +
        scale_fill_gradient(low = "white", high = "#0B3D91") +
        labs(title = "W&L Alumni Majors by City",
             x = "Major", y = "City", fill = "% of Alumni") +
        theme_minimal() +
        theme(
          plot.title = element_text(
            color = "#0B3D91",
            face = "bold",
            size = 16
          ),
          axis.title = element_text(size = 11),
          axis.text = element_text(color = "#444444"),
          panel.grid.minor = element_blank()
        ) +
        theme(axis.text.x = element_text(angle = 60, hjust = 1, size = 7))
    })

  }
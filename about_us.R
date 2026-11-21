
about_us_server <- function(input, output) {
  city_master <- read.csv("city_master_final.csv")
}

about_usPage <- tabPanel(
      "About Us!",
                         
      fluidRow(
      column(width = 12,
      h2("Meet the Team"),
      hr()
      )
    ),
# Team photos and bios
      fluidRow(
        column(
        width = 3,
        style = "text-align: center;",
        img(
          src = "Callie Hutton3 (2).jpg",
          alt = "Callie Hutton",
          style = "width: 150px; height: 150px; border-radius: 50%;
                  object-fit: cover; object-position: left center;"
      )
    ),
       column(
        width = 9,
        h3("Callie Hutton"),
        p("Callie Hutton is a senior History major and Data Science minor from Memphis, Tennessee. After she graduates, Callie will be working in Financial Risk Management in New York City. Her top three cities are New York City, Washington, DC, and Houston, TX!")
      )
    ),
    
     hr(),
      fluidRow(
      column(
        width = 3,
        style = "text-align: center;",
        img(
          src = "Zoe_headshot.PNG",
          alt = "Zoe Dolfis",
          style = "border-radius: 50%; width: 150px; height: 150px; object-fit: cover;"
      )
    ),
        column(width = 9,
          h3("Zoe Dolfis"),
          p("Zoe is a Business Administration major and Data Science minor from Fairfax, Virginia. Zoe is hoping to work in Consulting in Washington, D.C. after she graduates. Her top three post-grad cities are Charlotte, NC, Washington, D.C., and New York City!")
        )
      ),
  
    # Data sources and citations
    fluidRow(
       shinydashboard::box(
          title = "Citations",
          width = 12,
          tags$ul(
           tags$li("Washington and Lee University Alumni Office, alumni records, 2016-2025"),
            tags$li(tags$a(
            "City Resident Population Estimated in 2025, U.S. Census Bureau",
              href = "https://www.census.gov/data/tables/time-series/demo/popest/2020s-total-cities-and-towns.html",
              target = "_blank"
              )),
            tags$li(tags$a(
            "Where Rent Increased and Decreased Most – 2026 Study: 2025 Rent, Zillow",
              href = "https://smartasset.com/data-studies/rent-increases-2026",
              target = "_blank"
              )),
              tags$li(tags$a(
              "Labor Market Tightness: Where Is It Easiest — and Hardest — to Find a Job Right Now?, Indeed Hiring Lab",
                  href = "https://slate.com/technology/2016/05/squirrels-express-frustration-by-twitching-their-tails-researchers-say.html",
                  target = "_blank"
                )),
                tags$li(tags$a(
                "Indeed's Best Cities For Work, Indeed ",
                   href = "https://www.indeed.com/bestcities",
                    target = "_blank"
                )),
                tags$li(tags$a("Anthropic. (2026). Claude Sonnet 5.5 [Large language model]",
                      href = "https://claude.ai",
                      target = "_blank"
                ))
              )
            )
    )
)


                        
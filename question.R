# Rescale a vector to 0-1 so every question is worth the same.
rescale01 <- function(x) {
  if (max(x) == min(x)) return(rep(0, length(x)))
  (x - min(x)) / (max(x) - min(x))
}

# Maps each rent answer to its c(lower, upper) dollar range. Names must match the radio button values exactly.
rent_ranges <- list(
  "under1000" = c(0,    1000),
  "1000_1499" = c(1000, 1500),
  "1500_1999" = c(1500, 2000),
  "2000_2499" = c(2000, 2500),
  "2500_2999" = c(2500, 3000),
  "3000plus"  = c(3000, Inf)
)

# Scores each city's rent from 0 to 1: 1 inside the chosen range, fading to 0 as rent moves outside it. Over budget is penalized more than under budget, and cities with missing rent get 0.
rent_fit <- function(rent, range, tol = 500, under_weight = 0.25) {
  over  <- pmax(rent - range[2], 0)
  under <- pmax(range[1] - rent, 0)
  fit   <- 1 - (over + under_weight * under) / tol
  fit   <- pmax(fit, 0)
  fit[is.na(fit)] <- 0
  fit
}

questionPage <- tabPanel(
  "Find Your Ideal Post Grad City",
  
  
  radioButtons("q_industry", "1. Which industry interests you most?",
               choices = c("Insurance"          = "Industry_Insurance",
                           "Engineering"        = "Industry_Engineering",
                           "Accounting"         = "Industry_Accounting",
                           "Consulting"         = "Industry_Consulting",
                           "Finance"            = "Industry_Finance",
                           "Human Resources"    = "Industry_Human_Resources",
                           "Legal"              = "Industry_Legal",
                           "Technology"         = "Industry_Technology",
                           "Healthcare"         = "Industry_Healthcare",
                           "Government"         = "Industry_Government",
                           "Education"          = "Industry_Education",
                           "Nonprofit"          = "Industry_Nonprofit",
                           "Real Estate"        = "Industry_Real_Estate",
                           "Energy / Industrial" = "Industry_Energy_Industrial",
                           "Media / Marketing"  = "Industry_Media_Marketing",
                           "Consumer / Retail"  = "Industry_Consumer_Retail",
                           "Other"              = "Industry_Other"),
               selected = character(0)),   # character(0) = nothing pre-checked
  
  radioButtons("q_major", "2. What is your major?",
               choices = c("Accounting" = "Major_Accounting",
                           "Art History" = "Major_Art History",
                           "Biochemistry" = "Major_Biochemistry",
                           "Biology" = "Major_Biology",
                           "Business Administration" = "Major_Business Administration",
                           "Chemistry" = "Major_Chemistry",
                           "Classics" = "Major_Classics",
                           "Cognitive and Behavioral Science" = "Major_Cognitive and Behavioral Science",
                           "Computer Science" = "Major_Computer Science",
                           "East Asian Languages and Literatures" = "Major_East Asian Languages and Literatures",
                           "Economics" = "Major_Economics",
                           "English" = "Major_English",
                           "Environmental Studies" = "Major_Environmental Studies",
                           "Engineering" = "Major_Engineering",
                           "French" = "Major_French",
                           "Geology" = "Major_Geology",
                           "German" = "Major_German",
                           "History" = "Major_History",
                           "Independent Work" = "Major_Independent Work",
                           "Journalism" = "Major_Journalism",
                           "Mathematics" = "Major_Mathematics",
                           "Medieval and Renaissance Studies" = "Major_Medieval and Renaissance Studies",
                           "Music" = "Major_Music",
                           "Neuroscience" = "Major_Neuroscience",
                           "Philosophy" = "Major_Philosophy",
                           "Physics" = "Major_Physics",
                           "Politics" = "Major_Politics",
                           "Psychology" = "Major_Psychology",
                           "Religion" = "Major_Religion",
                           "Romance Languages" = "Major_Romance Languages",
                           "Russian Area Studies" = "Major_Russian Area Studies",
                           "Sociology and Anthropology" = "Major_Sociology and Anthropology",
                           "Spanish" = "Major_Spanish",
                           "Strategic Communication" = "Major_Strategic Communication",
                           "Studio Art" = "Major_Studio Art",
                           "Theater" = "Major_Theater"),
               selected = character(0)),
  
  radioButtons("q_size", "3. What size city do you want?",
               choices = c("Big city" = "big", "Small city" = "small",
                           "No preference" = "any"),
               selected = character(0)),
  
  radioButtons("q_rent", "4. What is the most you would pay for monthly rent?",
               choices = c("Under $1,000" = "under1000",
                           "$1,000–$1,499" = "1000_1499",
                           "$1,500–$1,999" = "1500_1999",
                           "$2,000–$2,499" = "2000_2499",
                           "$2,500–$2,999" = "2500_2999",
                           "$3,000 or more" = "3000plus",
                           "No preference" = "any"),
               selected = character(0)),
  
  radioButtons("q_community", "5. How important is an alumni community in your city?",
               choices = c("Important" = "yes",
                           "Somewhat important" = "medium",
                           "Not important" = "no"
                           ),
               selected = character(0)),
  
  # "none" is a choice so people who didn't play a sport / go Greek can answer
  radioButtons("q_sport", "6. Which sport did you play (or care about most)?",
               choices = c("None / not applicable" = "none",
                           "Baseball"            = "Baseball",
                           "Basketball"          = "Basketball",
                           "Cross-Country"       = "Cross-Country",
                           "Field Hockey"        = "Field Hockey",
                           "Football"            = "Football",
                           "Golf"                = "Golf",
                           "Lacrosse"            = "Lacrosse",
                           "Riding (Equestrian)" = "Riding (Equestrian)",
                           "Soccer"              = "Soccer",
                           "Swimming"            = "Swimming",
                           "Tennis"              = "Tennis",
                           "Track & Field (Indoor)"  = "Track & Field-In",
                           "Track & Field (Outdoor)" = "Track & Field-Out",
                           "Volleyball"          = "Volleyball",
                           "Wrestling"           = "Wrestling"),
               selected = character(0)),
  
  radioButtons("q_greek", "7. What is your Greek affiliation?",
               choices = c("None / not applicable" = "none",
                           "Independent"          = "Independent",
                           "Alpha Delta Pi"       = "Alpha Delta Pi",
                           "Alpha Kappa Alpha"    = "Alpha Kappa Alpha",
                           "Beta Theta Pi"        = "Beta Theta Pi",
                           "Chi Omega"            = "Chi Omega",
                           "Chi Psi"              = "Chi Psi",
                           "Delta Society"        = "Delta Society",
                           "Kappa Alpha"          = "Kappa Alpha",
                           "Kappa Alpha Theta"    = "Kappa Alpha Theta",
                           "Kappa Kappa Gamma"    = "Kappa Kappa Gamma",
                           "Kappa Sigma"          = "Kappa Sigma",
                           "Lambda Chi Alpha"     = "Lambda Chi Alpha",
                           "Phi Beta Sigma"       = "Phi Beta Sigma",
                           "Phi Delta Theta"      = "Phi Delta Theta",
                           "Phi Gamma Delta"      = "Phi Gamma Delta",
                           "Phi Kappa Psi"        = "Phi Kappa Psi",
                           "Phi Zeta Delta"       = "Phi Zeta Delta",
                           "Pi Beta Phi"          = "Pi Beta Phi",
                           "Pi Kappa Alpha"       = "Pi Kappa Alpha",
                           "Pi Kappa Phi"         = "Pi Kappa Phi",
                           "Sigma Alpha Epsilon"  = "Sigma Alpha Epsilon",
                           "Sigma Chi"            = "Sigma Chi",
                           "Sigma Nu"             = "Sigma Nu",
                           "Sigma Phi Epsilon"    = "Sigma Phi Epsilon"),
               selected = character(0)),
  
  actionButton("q_go", "Get my recommendation"),
  hr(),
  uiOutput("q_result")   # filled in by question_server()
)

question_server <- function(input, output) {
  
  # eventReactive: runs only when the button is clicked
  recs <- eventReactive(input$q_go, {
    
    # Stop quietly until every question is answered
    req(input$q_industry, input$q_major, input$q_size,
        input$q_rent, input$q_community, input$q_sport, input$q_greek)
    
    df    <- read.csv("city_master_done.csv", check.names = FALSE)
    score <- rep(0, nrow(df))
    
    # Q1 + Q2: share of a city's alumni in that industry / major
    score <- score + rescale01(df[[input$q_industry]] / df$Alumni_Count)
    score <- score + rescale01(df[[input$q_major]] / df$Alumni_Count)
    
    # Q3: city size (pop_2025)
    if (input$q_size == "big")   score <- score + rescale01(df$pop_2025)
    if (input$q_size == "small") score <- score + (1 - rescale01(df$pop_2025))
    
    # Looks up the user's range and adds each city's rent score to its total. Skipped for "No preference".
    if (input$q_rent != "any") {
      score <- score + rent_fit(df$Rent_2025, rent_ranges[[input$q_rent]])
    }
    
    # Q5: bigger alumni base = more points
    if (input$q_community == "yes") score <- score + rescale01(df$Alumni_Count)
    
    # Q6: sport. The sport column name IS the radio value, so we can index
    #     the data directly. "none" adds no points.
    if (input$q_sport != "none") {
      score <- score + rescale01(df[[input$q_sport]] / df$Alumni_Count)
    }
    
    # Q7: Greek org, same idea (Independent is also a column in your data)
    if (input$q_greek != "none") {
      score <- score + rescale01(df[[input$q_greek]] / df$Alumni_Count)
    }
    
    df$score <- score
    head(df[order(-df$score),
            c("City_State", "score", "Rent_2025", "pop_2025", "Alumni_Count")], 3)
  })
  
  output$q_result <- renderUI({
    r <- recs()
    tagList(
      h3("Your top matches"),
      tags$ol(lapply(seq_len(nrow(r)), function(i) {
        tags$li(strong(r$City_State[i]),
                sprintf(" - avg rent $%s, %s alumni",
                        format(r$Rent_2025[i], big.mark = ","),
                        r$Alumni_Count[i]))
      }))
    )
  })
}



# Deleted this chunk because lines 185-188 does the same thing. Wanted to keep it just incase though

# Q4: rent range
# if (input$q_rent == "under1000") {
#   score <- score + (df$Rent_2025 < 1000)
# }
# 
# if (input$q_rent == "1000_1499") {
#   score <- score + (df$Rent_2025 >= 1000 & df$Rent_2025 < 1500)
# }
# 
# if (input$q_rent == "1500_1999") {
#   score <- score + (df$Rent_2025 >= 1500 & df$Rent_2025 < 2000)
# }
# 
# if (input$q_rent == "2000_2499") {
#   score <- score + (df$Rent_2025 >= 2000 & df$Rent_2025 < 2500)
# }
# 
# if (input$q_rent == "2500_2999") {
#   score <- score + (df$Rent_2025 >= 2500 & df$Rent_2025 < 3000)
# }
# 
# if (input$q_rent == "3000plus") {
#   score <- score + (df$Rent_2025 >= 3000)
# }

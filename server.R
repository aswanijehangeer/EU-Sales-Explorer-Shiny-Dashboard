# Define server logic ----
server <- function(input, output, session) {
  
  
  # Filtering data based on user inputs ----
  filtered_data <- reactive({

    filter_data <- sales_data

    # Filtering based on selected Category ----
    if (input$category != "All") {
      filter_data <- filter_data %>%
        filter(Category == input$category)
    }

    # Filtering based on selected Region ----
    if (input$region != "All") {
      filter_data <- filter_data %>%
        filter(Region == input$region)
    }

    # Filtering based on selected Year ----
    if (input$year != "All") {
      filter_data <- filter_data %>%
        filter(Year == input$year)
    }

    # Filtering based on selected country ----
    if (input$country != "All") {
      filter_data <- filter_data %>%
        filter(Country == input$country)
    }

    return(filter_data)
  })

  # total number of customers
  num_customers <- reactive({

    filtered_data <- filtered_data()
    filtered_data %>%
      select(`Customer ID`) %>%
      distinct() %>%
      n_distinct()
  })

  # total sales
  total_sales <- reactive({
    filtered_data <- filtered_data()
    sum(filtered_data$Sales)
  })

  # total profit
  total_profit <- reactive({
    filtered_data <- filtered_data()
    sum(filtered_data$Profit)
  })

  # Rendering the value boxes
  output$total_customers <- renderText({
    num_customers()
  })

  output$total_sales <- renderText({
    total_sales()
  })

  output$total_profit <- renderText({
    total_profit()
  })
}

# Server logic ----
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
  
  # Shiny-alert if there is no data for selected inputs ----
  observe({
    if (nrow(filtered_data()) == 0) {
      shinyalert(
        title = "Data Not Available", 
        text = "Data is not available for the selected inputs.",
        type = "error",
        animation = TRUE,
        confirmButtonCol = "#007BC2",
        confirmButtonText = "BACK"
      )
    }
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
    total_sales <- sum(filtered_data$Sales)
    
    total_sales <- format(total_sales, big.mark = ",")
    
  })

  # total profit
  total_profit <- reactive({
    filtered_data <- filtered_data()
    total_profit <- sum(filtered_data$Profit)
    
    total_profit <- format(total_profit, big.mark = ",")
  })

  # Rendering the value boxes ----
  output$total_customers <- renderText({
    num_customers()
  })

  output$total_sales <- renderText({
    total_sales()
  })

  output$total_profit <- renderText({
    total_profit()
  })
  
  # Monthly Sales chart ----
  output$monthly_sales <- renderEcharts4r({
    
    filtered_data <- filtered_data()
    
    month_sales <- filtered_data |> 
      group_by(Month) |> 
      summarize(Sales = sum(Sales))
    
    month_sales |> 
      e_charts(Month) |> 
      e_line(Sales) |> 
      e_color("#007BC2") |> 
      e_legend(show = FALSE) |> 
      e_tooltip(trigger = "item") |> 
      e_toolbox_feature(feature = c("saveAsImage", "dataView"))
    
  })
  # Product Sales chart ----
  output$product_sales <- renderEcharts4r({
    
    filtered_data <- filtered_data()
    
    product_sales <- filtered_data |>
      group_by(`Product Name`) |>
      summarize(Sales = sum(Sales)) |>
      arrange(desc(Sales)) |>
      top_n(15)
    
    product_sales |> 
      e_charts(`Product Name`) |> 
      e_bar(Sales) |> 
      e_color("#007BC2") |> 
      e_legend(show = FALSE) |> 
      e_tooltip(trigger = "item") |> 
      e_toolbox_feature(feature = c("saveAsImage", "dataView")) |> 
      e_x_axis(axisLabel = 'none')
  })
  # Heat-map - The Number of Orders by Months and Years ----
  output$heat_map <- renderEcharts4r({
    
    filtered_data <- filtered_data()
    
    order_count <- filtered_data |>
      group_by(Year, Month) |>
      summarise(Orders = n(), .groups = 'drop')
    
    order_count |>
      e_charts(Month) |>
      e_heatmap(Year, Orders) |>
      e_visual_map(Orders,
                   inRange = list(color = c("#007BC2", "#4CBDF5", "#005B95"))) |>
      e_tooltip(trigger = "item") |>
      e_legend(show = FALSE) |> 
      e_toolbox_feature(feature = c("saveAsImage", "dataView")) |> 
      e_x_axis(axisLabel = 'none')
  })
  
}

ui <- page_sidebar(
  # include SCSS file
  tags$head(
    tags$style(sass(sass_file("www/style.scss")))
  ),
  # Title ----
  title = "European Sales Dashboard",
  # Theme ----
  theme = bs_theme(bootswatch = "shiny"),
  # Sidebar / input controls ----
  sidebar = sidebar(
    title = "Input Controls",
    pickerInput(
      "category", "Product Category",
      choices = c("All", unique(sales_data$Category)),
      selected = "All",
      options = pickerOptions(
        actionsBox = TRUE,
        liveSearch = TRUE)
    ),
    pickerInput(
      "region", "Region",
      choices = c("All", unique(sales_data$Region)),
      selected = "All",
      options = pickerOptions(
        actionsBox = TRUE,
        liveSearch = TRUE)
    ),
    pickerInput(
      "year", "Year",
      choices = c("All", unique(sales_data$Year)),
      selected = "All",
      options = pickerOptions(
        actionsBox = TRUE,
        liveSearch = TRUE)
    ),
    pickerInput(
      "country", "Country",
      choices = c("All", unique(sales_data$Country)),
      selected = "All",
      options = pickerOptions(
        actionsBox = TRUE,
        liveSearch = TRUE)
    )
  ),
  # Value boxes ----
  layout_columns(
    fill = FALSE,
    value_box(
      title = "SALES",
      value = textOutput("total_sales"),
      showcase = bsicons::bs_icon("currency-dollar")),
    
    value_box(
      title = "PROFIT",
      value = textOutput("total_profit"),
      showcase = bsicons::bs_icon("currency-dollar")),
      
      value_box(
        title = "# OF CUSTOMERS",
        value = textOutput("total_customers"),
        showcase = bsicons::bs_icon("people-fill"))
    ),
  # Main section ----
  layout_columns(
    # Monthly Sales plot ----
    card(
      full_screen = TRUE,
      card_header("Monthly Sales Trend"),
      echarts4rOutput("monthly_sales"),
    ),
    # Product Sales plot ----
    card(
      full_screen = TRUE,
      card_header("Sales Breakdown by Product"),
      echarts4rOutput("product_sales"),
    )
  ),
  # Heat-map
  card(
    full_screen = TRUE,
    card_header("The Number of Orders by Months and Years"),
    echarts4rOutput("heat_map")
  ),
  # Disconnect message on disconnection on App ----
  disconnectMessage()
)

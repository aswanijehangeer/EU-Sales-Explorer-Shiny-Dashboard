source("global.R")

ui <- page_sidebar(
   # title
  title = "European Sales Dashboard",
  # theme
  theme = bs_theme(bootswatch = "shiny"),
  
  # sidebar / input controls
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
  # value boxes
    layout_columns(
      fill = FALSE,
        value_box(
        title = "SALES",
        value = textOutput("total_profit"),
        showcase = bsicons::bs_icon("currency-dollar"),
        class = "left-box"),

        value_box(
        title = "PROFIT",
        value = textOutput("total_sales"),
        showcase = bsicons::bs_icon("currency-dollar"),
        class = "middle-box"),

        value_box(
        title = "# OF CUSTOMERS",
        value = textOutput("total_customers"),
        showcase = bsicons::bs_icon("people-fill"),
        class = "right-box")
      ),
  
  # main section
  layout_columns(
    # Plot - 1
    card(
      card_header("Plot"),
      echarts4rOutput("plot1")
    ),
    # Plot -2
    card(
      card_header("Plot"),
      echarts4rOutput("plot2")
    )
  ),
  # Plot - 3 Heat-map
  card(
    card_header("Heat-map"),
    echarts4rOutput("plot3")
  )
)

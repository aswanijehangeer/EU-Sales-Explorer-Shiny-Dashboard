# Loading required packages ----

library(tidyverse)
library(readxl)
library(scales)

library(shiny)
library(bslib)
library(shinyWidgets)
library(echarts4r)
library(sass)
library(shinyalert)
library(shinydisconnect)

# Importing data set (In my current working directory) ----
sales_data <- read_xls("data/Sample - EU Superstore.xls")

# Separating order_date column with Month and Year ----
sales_data <- sales_data |> 
  mutate(Year = year(`Order Date`),
         Month = month(`Order Date`, label = TRUE))

sales_data <- sales_data |> 
  rename(Country = `Country/Region`)


# Heat-map - The Number of Orders by Months and Years ----
# order_count <- sales_data |>
#   group_by(Year, Month) |>
#   summarise(Orders = n(), .groups = 'drop')
# 
# order_count |>
#   e_charts(Year) |>
#   e_heatmap(Month, Orders) |>
#   e_visual_map(Orders,
#                inRange = list(color = c())) |>
#   e_tooltip(trigger = "item") |>
#   e_legend(show = FALSE)
 
# Sales by Month ----

# month_sales <- sales_data |>
#   group_by(Month) |>
#   summarize(Sales = sum(Sales))
# 
# month_sales |>
#   ggplot(aes(Month, Sales)) +
#   geom_line(group = 1) +
#   geom_point() +
#   scale_y_continuous(limits = c(100000, 400000),
#                      labels = c("100k","200k","300k","400k"))

# Sales by Product ----

# product_sales <- sales_data |>
#   filter(Category == "Office Supplies") |>
#   group_by(`Product Name`) |>
#   summarize(Sales = sum(Sales)) |>
#   arrange(desc(Sales)) |>
#   top_n(15)
# 
# product_sales |>
#   ggplot(aes(`Product Name`, total_sales)) +
#   geom_bar(stat = "identity")


## Value boxes ----    

## Number of Customers

# num_customers <- sales_data %>%
#   select(`Customer ID`) %>%
#   distinct() %>%
#   n_distinct()
# 
# 
# # Total Sales
# 
# sales <- sum(sales_data$Sales)
# 
# # Total Profit
# profit <- sum(sales_data$Profit)


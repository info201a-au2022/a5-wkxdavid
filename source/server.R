library(tidyverse)
library(plotly)
library(shiny)
library(rsconnect)

server <- function(input, output) {

  # loads the dataset from github

  data_file <- read.csv("owid-co2-data.txt")

  # selects land use data
  land_use_data <- select(data_file, country, year, land_use_change_co2, land_use_change_co2_per_capita,
                          share_global_luc_co2, cumulative_luc_co2, ghg_excluding_lucf_per_capita,
                          ghg_per_capita, share_global_cumulative_co2_including_luc, total_ghg)
  
  interactive_data <- select(data_file, year, land_use_change_co2, land_use_change_co2_per_capita,
                          share_global_luc_co2, cumulative_luc_co2, ghg_excluding_lucf_per_capita,
                          ghg_per_capita, share_global_cumulative_co2_including_luc, total_ghg)
  
  # when is the average land use capita per country
  average_land_use_capita <- land_use_data %>%
    select(country, year, land_use_change_co2_per_capita) %>%
    group_by(country) %>%
    summarize(land_use_change_co2_per_capita = mean(land_use_change_co2_per_capita,
                                                   na.rm = TRUE))
  
  # gets the highest total cumulative land use c02
  # What the highest land-use c02 output?
  cumulative_land_use <- land_use_data %>%
    select(country, year, cumulative_luc_co2) %>%
    group_by(country) %>%
    summarize(cumulative_luc_co2 = sum(cumulative_luc_co2))
  
  # percent change
  percent_change_land_use <- land_use_data %>%
    arrange(year) %>%
    group_by(year) %>%
    mutate(pct_change = (lag(share_global_cumulative_co2_including_luc) -
                           share_global_cumulative_co2_including_luc)/
             share_global_cumulative_co2_including_luc * 100)
  
  
  # the bar chart
  output$chart <- renderPlot({
    barplot(interactive_data[,input$type], 
            main=input$type,
            ylab=input$type,
            xlab="Countries")
  })
  
  # creative picture
  output$home_pic <- renderImage({
    list(src ="land-use.png", width = "100%", height = 400)
  }, deleteFile = F)
}
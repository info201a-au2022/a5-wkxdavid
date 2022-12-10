library(rsconnect)
library(ggplot2)
library(shiny)
library(tidyverse)
library(plotly)
library(gganimate)
library(shinycssloaders)
library(thematic)

data_file <- "https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv"
c02_data <- read_csv(url(data_file))

            
land_use <- select(c02_data, land_use_change_co2_per_capita, year, country)
minimum <- min(land_use)
max <- max(land_use)


current_year <- filter(land_use, year == 1850)

one_country <- filter(land_use, country == "North America")
percent_change <- group_by(one_country) %>% 
  mutate(percent = (land_use_change_co2_per_capita	/lead(land_use_change_co2_per_capita	) - 1) * 100)

server <- function(input, output) {
  
  # loads the dataset from github
  data_file <- "https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv"
  c02_data <- read_csv(url(data_file))
  
  # removes non countries from the dataset
  remove_non_countries <- filter(c02_data, country == "World" & country != "Asia" &
                                 country != "Europe" & country != "Europe" &
                                 country != "North America" & country != 
                                 "Upper-middle-income countries" & country !=
                                 "High-income countries")
  
  # selects land use data
  land_use_data <- select(remove_non_countries, country, year, land_use_change_co2, land_use_change_co2_per_capita,
                          share_global_luc_co2, cumulative_luc_co2, ghg_excluding_lucf_per_capita,
                          ghg_per_capita, share_global_cumulative_co2_including_luc, total_ghg)
  
  # selects the capita data that will be used in this project
  capita_data <- select(remove_non_countries, country, year, co2_per_capita,
                        gas_co2_per_capita, ghg_per_capita, land_use_change_co2_per_capita, 
                        methane_per_capita, nitrous_oxide_per_capita, oil_co2_per_capita,
                        other_co2_per_capita, flaring_co2_per_capita, coal_co2_per_capita,
                        cumulative_luc_co2)

  # What is the lowewst and highest the capita has been for each category.
  remove_non_capita <- select(capita_data, co2_per_capita,
                              gas_co2_per_capita, ghg_per_capita, land_use_change_co2_per_capita, 
                              methane_per_capita, nitrous_oxide_per_capita, oil_co2_per_capita,
                              other_co2_per_capita, flaring_co2_per_capita, coal_co2_per_capita)
  high <- apply(remove_non_capita, 2, function(x) max(x, na.rm = TRUE))
  low <- apply(remove_non_capita, 2, function(x) min(x, na.rm = TRUE))
  
  # when is the average land use capita per country
  average_land_use_capita <- land_use_data %>%
    select(country, year, land_use_change_co2_per_capita) %>%
    group_by(country) %>%
    summarize(land_use_change_co2_per_capita = max(land_use_change_co2_per_capita,
                                                    na.rm = TRUE))
  #
  cumulative_land_use <- land_use_data %>%
    select(country, year, cumulative_luc_co2) %>%
    group_by(country) %>%
    summarize(cumulative_luc_co2 = max(cumulative_luc_co2,na.rm = TRUE))
  
  percent_change_land_use <- df %>%
    arrange(year) %>%
    group_by(year) %>%
    mutate(pct_change = (lag(share_global_cumulative_luc_co2) - 
                        share_global_cumulative_luc_co2)/share_global_cumulative_luc_co2 * 100)

  output$text <- renderText({
    p("Test")
  })
  
  
  
  
  output$temp <- renderPlot({
    barchart <- capita_data %>% 
      geom_bar()
  })
}
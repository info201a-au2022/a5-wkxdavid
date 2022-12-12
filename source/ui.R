library(tidyverse)
library(plotly)
library(shiny)
library(rsconnect)

# widgets

data_file <- read.csv("owid-co2-data.txt")

# text
introduction_text <- "The focus of this project is the CO2 emissions of land use. This is to explore
                      how land use may be affecting the change in climate change. The dataset used in this project
                      is from a github repoistory (https://github.com/owid/co2-data/). The dataset shows CO2 and greenhouse
                      emissions for many categories. Though this project will only be focusing on land-use emissions."
                      
relevant_values <- "The first relevant value of interest is what is the average land-use per capita. For the world, it is 2.464 tonnes per person. An second relevant value 
                      of interest is what is the cumulative land-use across the world which is 742490.60 tonnes total.
                      An third area of interest is what was the percent change of land-use in North America. 
                      And in 2019 to 2020, it had a 1.123 % change."

interactive_text <- "This bar chart is included to graph the varying levels of co2 via land change. 
                     This will show all of the varying levels between capita, cumulative, etc.
                     What is visibile between all of charts, is that they all have extreme varying levels
                     where some of them are very low and others go really high. This shows that different
                     countries and areas have vastly different c02 land use emissions."

  
land_use_rename <- c("Cumulative production based Co2" = "share_global_cumulative_co2_including_luc",
                     "Cumulative land use CO2" = "cumulative_luc_co2",
                     "Annual production of CO2 from land-use per capita" = "land_use_change_co2_per_capita",
                     "Annual production of CO2 based on territory " = "land_use_change_co2",
                     "Cumulative land-use emissions shared" = "share_global_luc_co2")

person_text <- "INFO 201 Fall 2022 A-5 - David Pham"

# introduction page
introduction <- tabPanel(
  "Introduction",
  imageOutput("home_pic"),
  titlePanel("Introduction"),
  p(introduction_text),
  p(relevant_values),
  p(person_text)
)

# interactive page
interactive <- tabPanel(
  "Bar Chart",
  titlePanel("Land Use per Capita"),
  sidebarLayout(
    sidebarPanel(
      selectInput("type", "Select a Emission type:", 
                  choices=land_use_rename), 
      
      selectInput("Country",
                  label = "Select a Country",
                  choices = unique(data_file$country)),
      p(interactive_text)
    ),
    mainPanel(plotOutput("chart")),

  )
)

# navigation bar
shinyui <- navbarPage(
    "Land-Use Co2 Emissions",
    introduction,
    interactive
)

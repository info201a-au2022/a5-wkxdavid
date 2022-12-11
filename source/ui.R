library(rsconnect)
library(ggplot2)
library(shiny)
library(tidyverse)
library(ggmap)
library(plotly)
library(gganimate)
library(shinycssloaders)
library(thematic)

# widgets

data_file <- read.csv("owid-co2-data.txt")
 
land_use_data <- select(data_file, land_use_change_co2, land_use_change_co2_per_capita,
                        share_global_luc_co2, cumulative_luc_co2, ghg_excluding_lucf_per_capita,
                        ghg_per_capita, share_global_cumulative_co2_including_luc, total_ghg)
# text
introduction_text <- "The focus of this project is the c02 emissions of land use. This is to explore
                      how land use may be affecting the change in climate change. One relevant value of interest
                      is what is the average land use per capita. For the world, it is 2.464 tonnes per person. Another relevant value 
                      of interest is what is the cumulative land use across the world which is 742490.60 tonnes total.
                      An third area of interest is what was the percent change of land use in North America. 
                      And in 2019 to 2020, it had a 1.123 % change."

interactive_text <- "This bar chart is included to graph the varying levels of co2 via land change. 
                     This will show all of the varying levels between capita, cumulative, etc.
                     What is visibile between all of charts, is that they all have extreme varying levels
                     where some of them are very low and others go really high. This shows that different
                     countries and areas have vastly different c02 land use emissions."

# introduction page
introduction <- tabPanel(
  "Introduction",
  imageOutput("home_pic"),
  titlePanel("Introduction"),
  p(introduction_text),
)

# interactive page
interactive <- tabPanel(
  "Bar Chart",
  titlePanel("Land Use per Capita"),
  sidebarLayout(
    sidebarPanel(
      selectInput("region", "co2 type:", 
                  choices=colnames(land_use_data)),
      p(interactive_text)
    ),
    mainPanel(plotOutput("barchart"))
  )
)

shinyui <- navbarPage(
    "Land use c02 emissions",
    introduction,
    interactive,
)

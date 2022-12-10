# loads libraries
library(rsconnect)
library(ggplot2)
library(shiny)
library(tidyverse)
library(ggmap)
library(plotly)
library(gganimate)
library(shinycssloaders)
library(thematic)

# sources the files needed to run the shiny website. They will work front end
# and back end with app_ui.r and app_server.r.
source("app_server.R")
source("app_ui.R")

# creates shiny app
shinyApp(ui = ui, server = server)

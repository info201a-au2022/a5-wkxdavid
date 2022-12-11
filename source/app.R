library(rsconnect)
library(ggplot2)
library(shiny)
library(tidyverse)
library(ggmap)
library(plotly)
library(gganimate)
library(shinycssloaders)
library(thematic)

source("app_server.R")
source("app_ui.R")

shinyApp(ui = ui, server = server)
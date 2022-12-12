library(tidyverse)
library(plotly)
library(shiny)
library(rsconnect)

source("app_server.R")
source("app_ui.R")

shinyApp(ui = ui, server = server)
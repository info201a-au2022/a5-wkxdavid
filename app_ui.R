library(rsconnect)
library(ggplot2)
library(shiny)
library(tidyverse)
library(ggmap)
library(plotly)
library(gganimate)
library(shinycssloaders)
library(thematic)

introduction <- tabpanel(
  "Introduction",
  titlePanel("Introduction"),
  introduction()
  textoutput(text)
)

introduction <- "This project produces a graph for c02 produced by land use."

shinyui <- fluidpage(
  navbarPage(
    "Land use c02 emissions",
    introduction
  )
)
library(ggvis)
library(shiny)
library(parcoords)
library(pairsD3)

ui <- fluidPage(
  headerPanel('Multivariate Analysis of Facebook Data'),
  mainPanel(
    tabsetPanel(
      tabPanel("Bubble Plot",
               headerPanel('Likes by Weekday, Paid vs. Unpaid Status Updates'),
               mainPanel(
                 uiOutput("ggvis_ui"),
                 ggvisOutput("ggvis")
               )),
      tabPanel("Scatterplot Matrix",
               headerPanel('Matrix of Interactions (With Brushing)'),
               mainPanel(
                 uiOutput("pd3plot")
               )
      ),
      tabPanel("Parallel Coordinates",
               headerPanel('Interactions by Category (With Brushing)'),
               mainPanel(
                 uiOutput("pcplot")
               ))
    )
  )
)
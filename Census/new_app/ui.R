library(shiny)
library(leaflet)


# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Low Response Scores for Boulder County"),

    # Sidebar with a slider input for number of bins
    mainPanel(
        leafletOutput("mapplot", height = "90vh")
        )
    )
    )

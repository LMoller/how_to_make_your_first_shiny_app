
library(shiny)
library(ggplot2)
library(dplyr)
library(shinyWidgets)

# Define UI for application that draws a plot
fluidPage(
  
  # Application title
  titlePanel("My First Shiny App"),
  
  # Sidebar with a dropdown for class
  sidebarLayout(
    sidebarPanel(
       pickerInput(inputId = "class_of_car",
                   label = "Class:", 
                   choices = c(unique(mpg$class)),
                   selected = c(unique(mpg$class)),
                   options = list(`actions-box` = TRUE, size = 12, `selected-text-format` = "count> 3"),
                   multiple = TRUE
                   )
    ),
    
    # Show a plot of mpg by displ, hwy and class
    mainPanel(
       plotOutput("mpgPlot")
    )
  )
)

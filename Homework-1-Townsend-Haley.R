## Homework 1: A Basic UI with Visuals
## R Shiny for Operations F18
## HALEY TOWNSEND

#Due Date: 9/7/2018

#Creating a basic UI is necessary to understanding how to organize shiny applications for users. 
#Students are expected to choose one of the layouts discussed during the first week of class and 
#create a basic layout using one of the generic datasets provided in some R packages (mtcars, diamonds, starwars, etc). 

#The UI should have two (2) input elements and one (2) plots and/or data table. 
#The input elements do not have to interact with the plots or data tables for this assignment, 
#they simply must be present in the UI.

##########################################################################################################################################

# Load libraries
require(ggplot2)
library(plyr)
require(dplyr)
require(tibble)
require(reshape2)
library(shiny)
library(shinyWidgets)
library(shinythemes)
library(plotly)

# For this HW, I will use the diamonds dataset. 
diamonds <- diamonds

# Creating a vector of colors for the "Select Color" input
col_options <- as.character(sort(unique(diamonds$color)))

# Creating the Shiny App 
ui <- fluidPage(navbarPage("Homework 1: Shiny for Operations F18 (Haley Townsend)",
                           theme = shinytheme('spacelab'),
                           sidebarLayout(
                             sidebarPanel(
                               sliderInput("p", label="Select Price in USD", min = min(diamonds$price), max = max(diamonds$price), 
                                           value=mean(diamonds$price)),
                               pickerInput("col", label="Select Color, in order from D (best) to J (worst)", choices = col_options, selected = col_options[1])
                             ),
                             mainPanel(fluidRow(
                               plotOutput("diamonds_plot1")),
                               fluidRow(plotOutput("diamonds_plot2"))
                           )
                )))

server <- function(input,output){
  
  output$diamonds_plot1 <- renderPlot({
    ggplot(diamonds, aes(x = cut, colour = cut, fill = cut)) + geom_bar() +
      ggtitle("The Number of Diamonds in the Data for Each Cut") + xlab("Cut") + ylab("Number in Dataset") +
      guides(fill=F, colour = F)
    })
  
  output$diamonds_plot2 <- renderPlot({
    ggplot(diamonds, aes(x = carat, y = price, fill = color, colour = color)) + 
      geom_point() + facet_wrap(~color) + ggtitle("Price Increases as Carat Increases for Every Diamond Color") + 
      ylab("Price in USD") + xlab("Carat")
  })
  
}

shinyApp(ui = ui, server = server)


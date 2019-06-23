library(shiny)
library(plotly)
shinyUI(fluidPage(
            titlePanel("Sachin Tendulkar Perfromance"),
            sidebarLayout(
                sidebarPanel(
            
                              selectInput("Opponent", "Choose a Opponent:", choices = c("Pakistan", "New Zealand", "England","Zimbabwe",
                                                               "Sri Lanka","West Indies","Australia","South Africa")),
                              submitButton("Refresh"),
                              
                              helpText("Note: The graph is showing the total run scored against given oppositon in each year played.",
                                       "Select Oposition and click Refresh button to get the respective detail")),
      
                mainPanel(
                              h3("Sachin Tendulkar's record against each Cricket playing Country"),
                              plotlyOutput("plot"),
                              
                              h4("Run Scored:"),
                              tableOutput("Run_Scored"))
                            )
                  )
        )

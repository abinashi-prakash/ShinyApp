##Include Supporting Library
library(shiny)
library(plotly)
library(lubridate)
library(dplyr)
library(ggplot2)

##Read Source Data from GITHUB repository
Sachin_Data <- read.csv("https://raw.githubusercontent.com/abinashi-prakash/ShinyApp/master/tendulkar.csv",header = TRUE,stringsAsFactors = F)

##Data Setup
Sachin_Runs <- data.frame(format(as.POSIXct(Sachin_Data$Start_Date,format="%d-%m-%Y"),"%Y") ,
                          substr(Sachin_Data$Opposition,3,15),Sachin_Data$Runs)
names(Sachin_Runs) <- c("Year", "Opposition", "Runs")
Sachin_Runs <- Sachin_Runs[!(Sachin_Runs$Runs == "" | is.na(Sachin_Runs$Runs) |Sachin_Runs$Runs == "DNB"), ]

##Get SUM of Runs scored for each opposition in a year
Sachin_Runs <- Sachin_Runs %>% group_by(Opposition,Year) %>% summarise("Runs" = sum(as.numeric(as.character(Runs))))

print(Sachin_Runs)

shinyServer(function(input, output) 
             {
  
                Rel_Sachin_Score <- reactive({
  
                      a <- subset(Sachin_Runs,input$Opponent==Sachin_Runs$Opposition)
   
                      return(a)
                                            })
     
  
                output$plot <- renderPlotly({
   
                        plot_ly(Rel_Sachin_Score(),x= ~Year,y = ~Runs,type = "bar")
                                           })
                output$Run_Scored <- renderTable({
                        Rel_Sachin_Score()
                                                })
  
             })
  

  

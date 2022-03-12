library(shiny)
library(shinythemes)
library(tidyverse)
library(plotly)
library(dplyr)
library(shinyjs)
library(DT)
library(leaflet)


metro.data1 <- readr::read_csv("metro.csv")%>%
  select(-1)

mapPanel <- tabPanel("cfnumPanel",                     
					# fluidRow(
					#   column(width=4,selectInput("selecta", label = h3("Selection date"), choices = as.character(unique(db_sale$day)), selected = '2017-09-01')),
					#   column(width=4,selectInput("selectb", label = h3("Select t_time"), choices = as.character(unique(db_sale$t_time)), selected = '0'))
					#  ),
					h4('Number of departures per hour at each station'), 
					fluidRow(
					  #--map1
					  column(width=12,leafletOutput("cfnum"))
					 ),
					h4('Number of arrivals per hour at each station'),					 
					fluidRow(
					  #--map2
					  column(width=12,leafletOutput("ddnum"))
					 )					 
							  )


## UI side
ui <- navbarPage("Substation",
                 mapPanel     
                 #,theme = shinythemes::shinytheme("united")
)

## Server side
server <- function(input, output) {
# map
output$cfnum <- renderLeaflet({
	      
		  leaflet(data = metro.data1) %>% addTiles() %>%
		  addMarkers(~ycoo, ~xcoo, popup = ~as.character(predicted), label = ~as.character(predicted))  
  }) 
  

# output$ddnum <- renderLeaflet({
# 	      tb=filter(db_sale ,day == input$selecta & t_time== input$selectb ) #tb=filter(db_sale ,day == '2017-09-01' & t_time=='0' )	  
# 		  leaflet(data = tb) %>% addTiles() %>%
# 		  addMarkers(~lng, ~lat, popup = ~as.character(ddnum), label = ~as.character(ddnum))  
#   }) 
  


}

# Run the application 
shinyApp(ui = ui, server = server)


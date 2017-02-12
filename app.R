library(ggplot2)
mpg<-mpg
library(dplyr)

library(shiny)
ui<-fluidPage(
  titlePanel('City miles per gallon per manufacturer (from mpg)'),
  sidebarLayout(
    sidebarPanel(
      selectInput('typeInput','Manufacturer',choices=(mpg$manufacturer))),
    mainPanel('city miles',
              plotOutput('hist'))
  )
)

server<-function(input,output){
  output$hist<-renderPlot({
    filtered<-
      mpg %>%
      filter(manufacturer==input$typeInput)
    ggplot(filtered,aes(cty))+geom_histogram(fill='steelblue')
  })
  observe({print(input$typeInput)})
  ctydiff<-reactive({
    diff(input$typeInput)
  })
}

shinyApp(ui=ui,server=server)



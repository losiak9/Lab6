library(shiny)

checkbox <- function(){
  data <- read.table("data.txt", sep = ";", header = TRUE, encoding = "UTF-8")
  result <- as.vector(data[,1])
  names(result) <- result
  return (result)
}

shinyUI(pageWithSidebar(
  headerPanel("Different countries GDP"),
  
  sidebarPanel(
    checkboxGroupInput("country", "Select country:", checkbox())
  ),
  
  mainPanel(
    plotOutput("plot")
  )
))
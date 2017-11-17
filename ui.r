library(shiny)

checkbox <- function(){
  data <- read.table("database.txt", sep = ";", header = TRUE, encoding = "UTF-8")
  data <- data[!(data[, 2] == '?'),]
  result <- as.vector(data[,1])
  names(result) <- result
  return (result)
}

shinyUI(pageWithSidebar(
  headerPanel("Cars"),
  
  sidebarPanel(
    checkboxGroupInput("year", "Select car date:", checkbox())
  ),
  
  mainPanel(
    plotOutput("plot")
  )
)
)

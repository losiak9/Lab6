as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}

read.data <- function(){
  data <- read.table("database.txt", sep = ";", header = TRUE, encoding = "UTF-8")
  for(col in 2:ncol(data)){
    data[, col] <- as.numeric.factor(data[, col])
  }
  return (data)
}

data <- read.data()

colors <- c("#FF0000", "#000cff", "#00ff0c", "#1a9b9d", "#750db1", "#1dc87a", "#ffa800", "#d44d0a", "#ca2149", "#3a58f0")

draw_ <- function(years, j){
  index <- 0
  
  for(i in 1:nrow(data)){
    if(data[i, 1] == years[j]){
      index <- i
    }
  }
  
  if(index == 0){
    return()
  }
  
  if(j == 1){
    plot(2:ncol(data), data[index, 2:ncol(data)], type = "o", xaxt = "n", xlab = "dist", ylab = "speed", col = colors[j], ylim = c(0,10))
  } else {
    lines(2:ncol(data), data[index, 2:ncol(data)], type = "o", xaxt = "n", xlab = "dist", ylab = "speed", col = colors[j])
  }
}

draw <- function(years){
  if(is.null(years)){
    return()
  }
  
  for(i in 1:length(years)){
    draw_(years, i)
  }
}

shinyServer(
  function(input, output) {
    output$plot <- renderPlot({
      draw(input$year)
    })
  }
)

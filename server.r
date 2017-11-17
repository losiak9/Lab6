read.data <- function(){
  data <- read.table("database.txt", sep = ";", header = TRUE, encoding = "UTF-8")
  for(col in 2:ncol(data)){
    data[, col] <- as.numeric.factor(data[, col])
  }
  return (data)
}

data <- read.data()

colors <- c("#1a9b9d", "#750db1", "#1dc87a")

draw_ <- function(countries, j){
  index <- 0
  
  for(i in 1:nrow(data)){
    if(data[i, 1] == countries[j]){
      index <- i
    }
  }
  
  if(index == 0){
    return()
  }
 
  if(j == 1){
    print(data[1, 2:51])
    
    plot(2:51, data[index, 2:51], type = "o", xaxt = "n",xlab = "Years", ylab = "Rate of GDP", col = colors[j], ylim = c(0,80000))
    axis(1, at = 1:length(data), labels = colnames(data))
  } else {
    lines(2:51, data[index, 2:51], type = "o", xaxt = "n", xlab = "Years", ylab = "Rate of GDP", col = colors[j])
  }
  legend("topright", legend = countries, col = colors, lty = 1)
}


draw <- function(countries){
  if(is.null(countries)){
    return()
  }
  
  
  for(i in 1:length(countries)){
    draw_(countries, i)
  }
}

shinyServer(
  function(input, output) {
    output$plot <- renderPlot({
      draw(input$country)
    })
  }
)

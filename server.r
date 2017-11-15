read.data <- function(){
  read.table("data.txt", sep = ";", header = TRUE, encoding = "UTF-8", check.names=FALSE)
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
    print(data[1, 2:25])
    
    plot(2:25, data[index, 2:25], type = "o", xaxt = "n",xlab = "Years", ylab = "Rate of GDP", col = colors[j], ylim = c(0,80000))
    axis(1, at = 1:length(data), labels = colnames(data))
  } else {
    lines(2:25, data[index, 2:25], type = "o", xaxt = "n", xlab = "Years", ylab = "Rate of GDP", col = colors[j])
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
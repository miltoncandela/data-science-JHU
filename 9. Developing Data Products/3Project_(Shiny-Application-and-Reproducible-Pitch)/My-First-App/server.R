#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

#' We will be using some external data, so we first download the data and
#' read it, I placed it on a github repository for reproducible research
#' purposes, we also included some initial formatting with read.csv()
urlfile <- 'https://raw.githubusercontent.com/milkbacon/9-Developing-Data-Products/main/data/diet.csv'
if(!file.exists('dietas.csv')){
       download.file(urlfile, 'dietas.csv')
}
diet <- read.csv('dietas.csv', col.names = c('USER', 'DATE', 'WEIGHT', 'BMI', 'BFP', 'MMP', 'VF'),
                 colClasses = c('factor', 'character', 'numeric', 'numeric', 'numeric', 'numeric','numeric'))

# Then we will set the date column to an actual date format 
diet[,'DATE'] <- as.Date(diet[,'DATE'], format = '%m/%d/%Y')

# This is the shinyServer function, here we will create our plot
shinyServer(function(input, output) {
       output$mainPlot <- renderPlot({
              
              #' Here we grab the values from the measurement and the person
              #' selected, these are the inputs from the ui.R
              measurement <- input$mesu
              person_selected <- input$pers
              
              #' This code is not required, it gives an unique color depending
              #' on which user is selected, this color is further used in
              #' the plot function to make each plot unique
              if(person_selected == 'BR'){
                     calar <- 'lightgreen'
              } else if (person_selected == 'WE'){
                     calar <- 'gray'
              } else if (person_selected == 'OL'){
                     calar <- 'hotpink'
              } else {
                     calar <- 'darksalmon'
              }
              
              #' Now we subset the data and pass all the information from
              #' the selected user to the new data frame
              person_diet <- diet[diet$USER == person_selected,]
              
              #' Then we got our code which made the plot, the first line is
              #' defining the information that is going in, as well as some 
              #' aesthetic aspects like color and labs. Then we fit a linear
              #' model line and place it on the plot, then we add a legend
              #' in order to say what does the line represent.
              plot(x = person_diet$DATE, y = person_diet[,measurement], pch = 20,
                   xlab = 'date', ylab = tolower(measurement), col = calar,
                   main = paste('Measurement of', measurement, 'from the user', person_selected, 'overtime'))
              abline(lm(person_diet[,measurement] ~ person_diet$DATE), col = 'red', lty = 4)
              legend('topright', 'Fitted line', lty = 2, col = 'red')
       })
})

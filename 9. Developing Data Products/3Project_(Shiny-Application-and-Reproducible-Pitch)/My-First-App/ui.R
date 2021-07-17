#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Here is the shinyUI function, where inputs will be extracted from here
shinyUI(fluidPage(

    # We then add a descriptive title for our application
    titlePanel("Measurement of health factors over time"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
               # We add nice descriptive text for our App
               helpText("Author = Milton Candela", tags$br(),"Date created = 27/01/2021"),
               helpText("This app let's you see the health information of four
                    users across the timestamp of two months, you can
                    personalize the information you see depending on the
                    parameters you select on the two sliders down below."),
               
               # Here is the first input, where user will be selected
               h5("Which user's information do you wish to see?"),
               selectInput('pers', 'Person:',
                           c('BR' = 'BR',
                             'WE' = 'WE',
                             'OL' = 'OL',
                             'MI' = 'MI')),
               
               # On the second input, measurement will be selected
               h5("Which measuremt do you wish to explore?"),
               selectInput('mesu', 'Measurement:',
                           c('Weight' = 'WEIGHT',
                             'Body Mass Index' = 'BMI',
                             'Body Fat Percentage' = 'BFP',
                             'Muscular Mass Percentage' = 'MMP',
                             'Viseral Fat' = 'VF'))
        ),
        # We then show the plot on the main panel
        mainPanel(
               plotOutput('mainPlot')
        )
    )
))

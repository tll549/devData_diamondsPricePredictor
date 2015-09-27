library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("Developing Data Products Course Project - Diamonds Price Predictor"),
    
    sidebarPanel(
        h3('Prediction Variables'),
        p('Modify these variables to see the price changes in the prediction field.'),
        sliderInput('carat', 'Carat (weight of the diamond)', min = 0.2, max = 5.01, value = 5.01),
        sliderInput('cut', 'Cut (quality of the cut; from 1 (worst) to (best) (Fair, Good, Very Good, Premium, Ideal))', min = 1, max = 5, value = 5),
        sliderInput('color', 'Color (from 7 (D, best) to 1 (J, worst))', min = 1, max = 7, value = 7, step = 1),
        sliderInput('clarity', 'Clarity (from 1 (worst) to 8 (best); I1 (worst), SI1, SI2, VS1, VS2, VVS1, VVS2, IF (best))', min = 1, max = 8, value = 8, step = 1),
        sliderInput('depth', 'Depth (total depth percentage = z / mean(x, y) = 2 * z / (x + y))', min = 43, max = 79, value = 79),
        sliderInput('table', 'Table (width of top of diamond relative to widest point)', min = 43, max = 95, value = 95),
        sliderInput('x', 'X (length in mm)', min = 0, max = 10.74, value = 10.74),
        sliderInput('y', 'Y (width in mm)', min = 0, max = 58.9, value = 58),
        sliderInput('z', 'Z (depth in mm)', min = 0, max = 31.8, value = 31.8),
        
        h3('Drawing Variables'),
        p('Change the x-axis and color-by variables to plot.'),
        radioButtons('xVar', 'x-axis variable (continuous)', list('Carat' = 'carat', 'Depth' = 'depth', 'Table' = 'table', 'x' = 'x', 'y' = 'y', 'z' = 'z'), 'carat'),
        radioButtons('colorVar', 'Color-by variable (order)', list('Cut' = 'cut', 'Color' = 'color', 'Clarity' = 'clarity'), 'cut')
    ),
    
    mainPanel(
        h3('Introduction'),
        p('Author: T.T'),
        p('This price predictor takes diamonds dataset in ggplot2 package as learning data (note: in order to simplify, all data are used to train the model without cross validation), fits mulitple linear regression model. All informations about variables are listed in side bar panel.'),
        p("You can use this predictor to predict your diamond's value! But there is no guarantee about the accuracy."),
        
        h3('Model Coefficients'),
        p('This linear model is simply called by:'),
        verbatimTextOutput('modCall'),
        p('The coefficeints are listed below:'),
        tableOutput('modfit'),
        
        h3('Prediction'),
        p('This prediction is predicted from the selected value in prediction variables panel.'),    
        verbatimTextOutput('prediction'),
        
        h3('Plot'),
        p('This plot is drawn by ggplot2 package, the x-axis variable and color-by variable can by picked in side bar panel.'),
        plotOutput("plot")
    )
))
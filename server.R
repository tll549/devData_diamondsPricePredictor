library(shiny)

# load the dataset
library(ggplot2)
data("diamonds")

# preprocess
library(plyr)
library(dplyr)
diamonds$cut <- mapvalues(diamonds$cut, c('Fair', 'Good', 'Very Good', 'Premium', 'Ideal'), c(1:5)) %>% as.integer()
diamonds$color <- mapvalues(diamonds$color, c('J', 'I', 'H', 'G', 'F', 'E', 'D'), c(1:7)) %>% as.integer()
diamonds$clarity <- mapvalues(diamonds$clarity, c('I1', 'SI1', 'SI2', 'VS1', 'VS2', 'VVS1', 'VVS2', 'IF'), c(1:8)) %>% as.integer()

# model fitting
mod <- lm(price ~ ., data = diamonds)
# mod_wo_interaction <- lm(price ~ carat + x, data = diamonds)

# int variables: cut color clarity
# qplot(carat, price, color = cut, data = diamonds, size = 2)
# qplot(depth, price, color = color, data = diamonds)
# g <- ggplot(data = diamonds, aes(price, carat, color = color))
# g <- g + geom_point()
# g
# prediction


shinyServer(
    function(input, output){
        
        output$modfit <- renderTable({
            summary(mod)
        })
        output$modCall <- renderPrint({
            summary(mod)$call
        })
        
        output$prediction <- renderPrint({
            newdata <- data.frame(carat = input$carat, cut = input$cut, color = input$color, clarity = input$clarity, depth = input$depth, table = input$table, x = input$x, y = input$y, z = input$z)
            predict(mod, newdata = newdata)
        })

        
        output$plot <- renderPlot({
#             g <- ggplot(data = diamonds, aes(diamonds$price, diamonds$x, color = diamonds[[by]]))
#             g <- g + geom_point()
#             g
            
            # if (input$xVar == 'carat'){
#             g <- ggplot(aes(carat, price, color = color), data = diamonds) + geom_point() + geom_point(aes(3, 10000, color = '3'), size = 10)
#             g
            # }
            
            qplot(diamonds[[input$xVar]], price, color = diamonds[[input$colorVar]], data = diamonds, xlab = input$xVar)
        })
    }
)



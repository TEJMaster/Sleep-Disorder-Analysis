#### Preamble ####
# Purpose: To provide an interactive tool for predicting the likelihood of sleep troubles based on individual sleep patterns.
# Author: Terry Tu
# Date: 17 April 2024
# Contact: xiangyu.tu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 'shiny', 'dplyr', 'shinyjs'

# Load required libraries
library(shiny)
library(dplyr)
library(shinyjs)  # for using JavaScript to dynamically change styles

# Define UI
ui <- fluidPage(
  useShinyjs(),  # Initialize shinyjs
  titlePanel("Sleep Trouble Prediction Tool"),
  tags$p("This interactive tool allows users to input their own sleep patterns to predict the likelihood of reporting sleep troubles. Based on a logistic regression model, the application estimates the probability that an individual might report sleep issues to a healthcare provider. To learn more about the data and model, visit the GitHub repository: https://github.com/TEJMaster/Sleep-Disorder-Analysis."),
  sidebarLayout(
    sidebarPanel(
      numericInput("weekdaySleep", "Weekday Sleep Duration (hours)", value = 8, min = 2, max = 14),
      numericInput("weekendSleep", "Weekend Sleep Duration (hours)", value = 8, min = 2, max = 14),
      selectInput("snoringFrequency", "How often do you snore?",
                  choices = c("Never" = 0, 
                              "Rarely - 1-2 nights a week" = 1, 
                              "Occasionally - 3-4 nights a week" = 2, 
                              "Frequently - 5 or more nights a week" = 3)),
      selectInput("breathingPause", "How often do you snort or stop breathing",
                  choices = c("Never" = 0, 
                              "Rarely - 1-2 nights a week" = 1, 
                              "Occasionally - 3-4 nights a week" = 2, 
                              "Frequently - 5 or more nights a week" = 3)),
      selectInput("overlySleepy", "How often feel overly sleepy during day?",
                  choices = c("Never" = 0, 
                              "Rarely - 1 time a month" = 1, 
                              "Sometimes - 2-4 times a month" = 2, 
                              "Often - 5-15 times a month" = 3, 
                              "Almost always - 16-30 times a month" = 4)),
      actionButton("predict", "Predict Probability")
    ),
    mainPanel(
      uiOutput("probability") 
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  observeEvent(input$predict, {
    # Coefficients from the model
    intercept <- -1.396
    coef_weekday_sleep <- 0.051
    coef_weekend_sleep <- -0.131
    coef_snoring_frequency <- 0.032
    coef_breathing_pause <- 0.412
    coef_overly_sleep_frequency <- 0.425
    
    # Calculate logit(p)
    logit_p <- intercept +
      coef_weekday_sleep * as.numeric(input$weekdaySleep) +
      coef_weekend_sleep * as.numeric(input$weekendSleep) +
      coef_snoring_frequency * as.numeric(input$snoringFrequency) +
      coef_breathing_pause * as.numeric(input$breathingPause) +
      coef_overly_sleep_frequency * as.numeric(input$overlySleepy)
    
    # Calculate probability p
    probability_p <- exp(logit_p) / (1 + exp(logit_p))
    
    # Output the probability
    output$probability <- renderUI({
      style <- if (probability_p < 0.3) {
        "color:green;"
      } else if (probability_p >= 0.3 && probability_p <= 0.7) {
        "color:orange;"
      } else {
        "color:red;"
      }
      HTML(sprintf("<span style='%s'>Predicted probability of reporting sleep troubles: %.3f</span>", style, probability_p))
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)

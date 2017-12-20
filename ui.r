library(shiny)
shinyUI(fluidPage(
  headerPanel("Twitter Sentiment Analysis"),
  sidebarPanel( textInput("term", "Enter a term to search", ""),
                sliderInput("count",
                            label = "Number of tweets to load:",
                            min = 0, max = 200, value = 0),
                numericInput("obs", "Number of tweets you want to view:", 5),
                selectInput("lang","Select the language",
                            c("English"="en"
                              ), selected = "en"),
                submitButton(text="Run")),
  mainPanel(
    h4("Last few Tweets"),
    tableOutput("table"),
    plotOutput("wordcl"))
))

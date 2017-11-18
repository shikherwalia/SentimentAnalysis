library(shiny) 


shinyUI(fluidPage( 
  titlePanel("Twitter Sentiment Analysis"), 
  sidebarLayout( 
    sidebarPanel( 
      textInput("searchTerm", label = "Enter twitter search keywords below", value = "#srk"),
      selectInput('plot_opt', 'Plot options', c('emotion', 'polarity'), selectize=TRUE), 
      submitButton("View") 
    ), 
    
    mainPanel(
      tabsetPanel(
        tabPanel("Sentiment analysis for the given word ",plotOutput("plot_emotion")),
        tabPanel("Wordcloud", plotOutput("wordcloudform"))
        
      )
      )
      
      ) 
  ) 
)

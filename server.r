rm(list = ls())



library('devtools')
library(tm) 
library(SnowballC) 
library(ggplot2) 
library(scales) 
library(Rgraphviz) 
library(wordcloud) 
library(rpart)
library(ROCR)   
library(pROC)   
library('MASS')
library('devtools')
library(sentiment) 
library(twitteR) 
library(plyr) 
library(RColorBrewer) 
library(e1071) 
library(RTextTools) 
library(Rstem)
library(ROAuth) 
library(shiny) 

load("credentials.RData")


source("totalcleanupneeded.R")


source("cleanuptweets.R")

 
source("wordcloud.R")




shinyServer(function(input, output) {
  
   
  
  tweets <- reactive ({ searchTwitter(input$searchTerm,n=1000, lang="en") }) 
  
  
   
  txtTweets.1 <- reactive ({ sapply(tweets(),function(x) x$getText()) })
  
  
  txtTweets.2 <- reactive ({ cleanTweets (txtTweets.1()) }) 
  txtTweets   <- reactive ({ cleanTweetsAndRemoveNAs (txtTweets.2()) }) 
  
  output$plot_emotion <- renderPlot({
    emotion <- emotionSentimentAnalysis(txtTweets())
    

    polarity <- polaritySentimentAnalysis(txtTweets())
    

    final_result.df <- reactive ({ data.frame(text = txtTweets(), emotion = emotion , polarity = polarity) })
    

    
    if (input$plot_opt == "emotion"){
      ggplot(final_result.df()) + 
        geom_bar(aes(x=emotion, y=..count.., fill=emotion)) + 
        ggtitle(paste('Tweet Sentiment Analysis "', input$searchTerm, '"', sep='')) +       
        xlab("Emotion Class") + ylab("No of Tweets") + 
        scale_fill_brewer(palette="Set1") + 
        theme_bw() + 
        theme(axis.text.y = element_text(colour="black", size=18, face='plain')) + 
        theme(axis.title.y = element_text(colour="black", size=18, face='plain', vjust=2)) +  
        theme(axis.text.x = element_text(colour="black", size=18, face='plain', angle=90, hjust=1)) + 
        theme(axis.title.x = element_text(colour="black", size=18, face='plain')) +  
        theme(plot.title = element_text(colour="black", size=20, face='plain', vjust=2.5)) + 
        theme(legend.text = element_text(colour="black", size=16, face='plain')) + 
        theme(legend.title = element_text(colour="black", size=18, face='plain')) + 
        guides(fill = guide_legend(keywidth = 2, keyheight = 2)) 
    } else {
      ggplot(final_result.df(), aes()) + 
        geom_bar(aes(x=polarity, y=..count.., fill=polarity), width=0.6) + 
        ggtitle(paste('Tweet Sentiment Analysis of Search Term "', input$searchTerm, '"', sep='')) + 
        xlab("Polarity Class") + ylab("No of Tweets") +    
        scale_fill_brewer(palette="Set1") + 
        theme_bw() + 
        theme(axis.text.y = element_text(colour="black", size=18, face='plain')) + 
        theme(axis.title.y = element_text(colour="black", size=18, face='plain', vjust=2)) +  
        theme(axis.text.x = element_text(colour="black", size=18, face='plain', angle=90, hjust=1)) + 
        theme(axis.title.x = element_text(colour="black", size=18, face='plain')) +  
        theme(plot.title = element_text(colour="black", size=20, face='plain', vjust=2.5)) + 
        theme(legend.text = element_text(colour="black", size=16, face='plain')) + 
        theme(legend.title = element_text(colour="black", size=18, face='plain')) + 
        guides(fill = guide_legend(keywidth = 2, keyheight = 2)) 
      
    }  
    
    })
  
  output$wordcloudform <- renderPlot({
    emotion <- emotionSentimentAnalysis(txtTweets())
    
    polarity <- polaritySentimentAnalysis(txtTweets())
    
    final_result.df <- reactive ({ data.frame(text = txtTweets(), emotion = emotion , polarity = polarity) })
    
    return(getWordCloud(final_result.df(),txtTweets(),emotion))

  })
})  
  









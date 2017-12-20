library(shiny)
library(twitteR)
library(wordcloud)
library(tm)
shinyServer(function (input, output) {
  rawData = reactive(function(){
    tweets = searchTwitter(input$term, n=input$count, lang=input$lang)
    tweets = twListToDF(tweets)
  })
  output$table = renderTable(function () {
    head(rawData()[1],n=input$obs)
  })
  output$wordcl = renderPlot(function(){
    tw.text = enc2native(rawData()$text)
    tw.text = tolower(tw.text)
    tw.text = removeWords(tw.text,c(stopwords(input$lang),"rt"))
    tw.text = removePunctuation(tw.text,TRUE)
    tw.text = unlist(strsplit(tw.text," "))
    word = sort(table(tw.text),TRUE)
    wordc = head(word,n=50)
    wordcloud(names(wordc),wordc,random.color=TRUE,colors=rainbow(10),scale=c(15,2))
  })
})

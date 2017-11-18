library(wordcloud)
library(RColorBrewer)
removeCustomeWords <- function (inText) {
  for(i in 1:length(inText)){
    inText[i] <- tryCatch({
      inText[i] =  removeWords(inText[i], c(stopwords("english")))
      inText[i]
    }, error=function(cond) {
      inText[i]
    }, warning=function(cond) {
      inText[i]
    })
  }
  return(inText)
}




getWordCloud <- function (txtdataframe , inText , emotion ) {
  emos = levels(factor(txtdataframe$emotion))
  n_emos = length(emos)
  emo.docs = rep("", n_emos)
  txtTweets = removeCustomeWords(inText)
  
  for (i in 1:n_emos){
    emo.docs[i] = paste(txtTweets[emotion == emos[i]], collapse=" ")
  }
  corpus = Corpus(VectorSource(emo.docs))
  tdm = TermDocumentMatrix(corpus)
  tdm = as.matrix(tdm)
  colnames(tdm) = emos
  require(wordcloud)
  suppressWarnings(comparison.cloud(tdm, colors = brewer.pal(n_emos, "Dark2"),  scale = c(3,.5), random.order = FALSE, title.size = 1.5))
}
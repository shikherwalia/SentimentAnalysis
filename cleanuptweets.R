catch.error = function(x)
{
  
  y = NA
    catch_error = tryCatch(tolower(x), error=function(e) e)
  
  if (!inherits(catch_error, "error"))
    y = tolower(x)
  
  return(y)
}


cleanTweets<- function(tweet){
  
  tweet = gsub("(f|ht)(tp)(s?)(://)(.*)[.|/](.*)", " ", tweet)
  
  tweet = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", " ", tweet)
  
  tweet = gsub("#\\w+", " ", tweet)
  
  tweet = gsub("@\\w+", " ", tweet)
  tweet = gsub("[[:punct:]]", " ", tweet)

  tweet = gsub("[[:digit:]]", " ", tweet)
  tweet = gsub("[ \t]{2,}", " ", tweet)
  tweet = gsub("^\\s+|\\s+$", "", tweet)
  tweet = catch.error(tweet)
  tweet
}

cleanTweetsAndRemoveNAs<- function(Tweets) {
  TweetsCleaned = sapply(Tweets, cleanTweets)
  
  TweetsCleaned = TweetsCleaned[!is.na(TweetsCleaned)]
  names(TweetsCleaned) = NULL
    TweetsCleaned = unique(TweetsCleaned)
  TweetsCleaned
}




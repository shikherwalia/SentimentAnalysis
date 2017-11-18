rm(list=ls())
library("twitteR")
library("ROAuth")
library(base64enc)

consumer_key = "4JTnQWS4GTjiAUMAip9cOOgTN"
consumer_secret = "YrvhqyjBqisvPY3rPYKJDbsj51ZwDMCVMv5xQabuE5uPu7qCaS"
access_token <- "113685444-c9IyRYDFjzT3aWVQHfIurw2BKfR2YNX79TsNBkBP"
access_secret <- "rW0S53xj24z1dHZAq5hLEEApeQ09si0nhIdolQxtNYvoN"

cred <- setup_twitter_oauth(consumer_key, consumer_secret, access_token  , access_secret)






















 


save(cred ,file="C:\\Users\\Shikher Walia\\Desktop\\Sentiment-Analysis-on-Twitter-Data-with-Shiny--master\\credentials.RData")



library(tidyverse)
library(skimr)
library(tm)
library(SnowballC)

df <- read.csv("./IMDB Dataset.csv")

# Understanding the data and evaluating problems
skim(df)
head(df)
View(df)
sample_df <- df %>%
  sample_n(100)
print(sample_df$review)


data_preprocess <- function(text) {
  
}
# Performing the operations on smaller scle
sample_df$review <- sapply(sample_df$review, function(text) {
  text <- tolower(text)
  text <- str_remove_all(text, "<[^>]+>")
  text <- removeWords(text, stopwords("en"))
  text <- gsub("[[:punct:]]+", " ", text)
  text <- wordStem(text,"en")
  text <- removeNumbers(text)
  text <- gsub("[\U0001F600-\U0001F64F\U0001F300-\U0001F5FF\U0001F680-\U0001F6FF\U0001F700-\U0001F77F\U0001F780-\U0001F7FF\U0001F800-\U0001F8FF\U0001F900-\U0001F9FF]", "", text, perl = TRUE)
  text <- gsub("\\b\\w{1,2}\\b", "", text)
  text <- gsub("\\s+", " ", text)
  text <- trimws(text)
})


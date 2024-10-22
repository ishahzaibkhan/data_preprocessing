library(tidyverse)
library(skimr)
library(tm)
library(SnowballC)

# Function to clean text data
clean_text <- function(text_vector) {
  cleaned_text <- sapply(text_vector, function(text) {
    text <- tolower(text) # Converting to Lowercase
    text <- str_remove_all(text, "<[^>]+>") # Removing HTML syntax using regex
    text <- removeWords(text, stopwords("en")) # Removing stopwords
    text <- gsub("[[:punct:]]+", " ", text) # Removing punctuation using regex
    text <- wordStem(text, "en") # Stemming
    text <- removeNumbers(text) # Removing Numbers
    # Removing emojis using regex
    text <- gsub("[\U0001F600-\U0001F64F\U0001F300-\U0001F5FF\U0001F680-\U0001F6FF\U0001F700-\U0001F77F\U0001F780-\U0001F7FF\U0001F800-\U0001F8FF\U0001F900-\U0001F9FF]", "", text, perl = TRUE)
    text <- gsub("\\b\\w{1,2}\\b", "", text) # Removing words with up to 2 letters that have no impact especially after stemming
    text <- gsub("\\s+", " ", text) # Removing excess spaces
    text <- trimws(text) # Removing the spacing before the text starts/ends
    
    return(text) 
  })
  
  return(cleaned_text)
}

df <- read.csv("./IMDB Dataset.csv")

# Understanding the data and evaluating problems
skim(df)
head(df)
View(df)

# Taking sample from the 50k rows
sample_df <- df %>%
  sample_n(100)

# Performing the operations on smaller scale
sample_df$review <- clean_text(sample_df$review)

# Performing the operation on entire data
clean_data <- clean_text(df$review)
df$review <- clean_data

write.table(df, file = "./cleaned_data.txt", sep = ",", row.names = FALSE, col.names = TRUE, quote = FALSE)
write.csv(df, file = "./cleaned_data.csv", row.names = FALSE)


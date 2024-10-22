library(tidyverse)
library(skimr)

df <- read.csv("./IMDB Dataset.csv")

# Understanding the data and evaluating problems
skim(df)
head(df)
View(df)
sample_df <- df %>%
  sample_n(10)
print(sample_df$review)

# Problems (Review Column)
# Mixed case i.e upper and lower case
# Html tags/symbols
# Punctuation

# Converting into lowercase
df$review <- tolower(df$review)


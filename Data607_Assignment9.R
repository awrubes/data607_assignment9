library(tidyverse)
library(dplyr)
library(httr2)
library(jsonlite)

base_url <- 'https://api.nytimes.com/svc/books/v3/lists/'
info_url <- 'current/hardcover-fiction.json?api-key=dlj6gAcTdtsvIwV1vgv8qKiKvJYa82wB'
full_url <- base::paste0(base_url,info_url)
full_url
api_call <- httr::GET(full_url)
api_call$status_code
api_call$content
api_char <- base::rawToChar(api_call$content)
api_JSON <- jsonlite::fromJSON(api_char, flatten=TRUE)
df <- as.data.frame(api_JSON$results$books)
glimpse(df)
View(df)

df_publisher <- df %>%
  count(publisher) %>%
  arrange(desc(n))

print(df_publisher)

df_sorted <- df %>%
  arrange(desc(weeks_on_list))

View(df_sorted)


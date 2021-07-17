library(ngram)
library(tokenizers)
library(dplyr)
library(tidyverse)
library(tm)


## A helper functiont hat read the files
fileRead <- function(file) {
  camino <- paste('data/final/en_US/en_US.', file, '.txt', sep = '') # The path of the files
  con <- file(camino, 'r') # Connection to the file is opened
  doc <- readLines(con, skipNul = TRUE) # The document is read depending on the connection opened
  close(con) # The connection is closed
  return(doc)
}

## This function returns the text used

readSampling <- function(){
  blogsFile <- fileRead('blogs')
  twitterFile <- fileRead('twitter')
  newsFile <- fileRead('news')
  
  num_lines <- c(length(newsFile), length(twitterFile), length(blogsFile)) * .33 # Considering 25% of the total lines
  
  set.seed(850)
  
  song <- c(newsFile[sample(1:num_lines[1])], twitterFile[sample(1:num_lines[2])], blogsFile[sample(1:num_lines[3])])
  
  #print(head(song, 20))
  
  song <- gsub(pattern = '\\W', replace = ' ', song)
  song <- gsub(pattern = '\\d', replace = ' ', song)
  song <- gsub(pattern = '[^a-zA-Z]', replace = ' ', song)
  song <- tolower(song)
  
  #song <- removeWords(song, stopwords())
  song <- gsub(pattern = '\\b[A-z]\\b{1}', replace = ' ', song)
  
  song <- stripWhitespace(song)
  song <- gsub(pattern = '^\\W', replace = '', song)
  song <- gsub(pattern = '^\\s', replace = '', song)
  song <- gsub(pattern = '\\s$', replace = '', song)
  
  return(song)
}

song <- readSampling()
head(song, 20)

## Helper function to create the ngrams

gramGen <- function(fulltext, n){
  tokens <- unlist(tokenize_ngrams(fulltext, n = n))
  tokens_na <- na.omit(tokens)
  
  ng <- ngram(tokens_na, n = n)
  phra <- get.phrasetable(ng)
}

## Generates every ngram

system.time(
  #monogram <- gramGen(song, 1)
)
system.time(
  bigram <- gramGen(song, 2)
)
system.time(
  trigram <- gramGen(song, 3)
)
system.time(
  fougram <- gramGen(song, 4)
)
system.time(
  fivgram <- gramGen(song, 5)
)
system.time(
  sixgram <- gramGen(song, 6)
)
system.time(
  sevgram <- gramGen(song, 7)
)
system.time(
  eiggram <- gramGen(song, 8)
)

all_words <- unlist(tokenize_ngrams(song, n = 1))

#all_grams <- list(all_words, bigram, trigram, fougram, fivgram, sixgram, sevgram, eiggram)
all_grams <- list(all_words, bigram, trigram, fougram)

## Gets the next word

get_word <- function(text, n){
  
  curr_gram <- all_grams[[n]]
  
  word <- FALSE
  
  #print(n)
  
  search_word <- paste('^', text, ' [a-zA-Z]', sep = '')

  if (sum(grep(search_word, curr_gram$ngrams)) != 0){
    propable_sentences <- curr_gram[grep(search_word,curr_gram$ngrams), ]
    
    #print(text)
    print(head(propable_sentences, 20))
    
    sentence <- propable_sentences[propable_sentences$prop == max(propable_sentences$prop), 1]
    word <- strsplit(sentence[1], split = ' ')[[1]][n]
  }
  
  return(word)
}

nextword <- function(text){
  ## First we start with the fivegram and we go until a monogram if we do not get success
  
  if(sum(strsplit(text, split = ' ')[[1]] %in% all_words) != count_words(text)){
    return('')
  }
  
  for(n in 4:1){
    
    if (length(strsplit(text, split = ' ')[[1]]) == (n - 1)){
      
      print(paste('Inputs for get_word function:', text, n))
      word <- get_word(text,n)
      
      if(class(word) == 'character'){
        return(word)
      }
      
      text <- word(text, 2:wordcount(text), -1)[1]
    }
  }
  
  return('')
  
}

text1 <- 'a case of'
text2 <- 'would mean the'
text3 <- 'make me the'
text4 <- 'struggling but the'
text5 <- 'date at the'
text6 <- 'be on my'
text7 <- 'in quite some'
text8 <- 'with his little'
text9 <- 'faith during the'
text10 <- 'you must be'

# ngrams: chr
# freq: int
# prop: num

df <- data.frame(texts = c(text1, text2, text3, text4,text5, text6, text7, text8, text9, text10))

for(text in df$texts){
  print(paste('*** Prediction of the text chunk:', text, '***'))
  print(nextword(text))
  print(paste('*** Prediction finished ***'))
  print('////////////////////////////')
}
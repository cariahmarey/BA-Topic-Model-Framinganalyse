options(stringsAsFactors = FALSE)
library(quanteda)
require(topicmodels)
library(xlsx)
library(lda)
library(ldatuning)
library(tm)
library(xlsx)
library(quanteda.textstats)
library(bayesplot)
library(ggplot2)
library(qdap)
library(tidyverse)
library(LDAvis)
library(tsne)
library(htmltools)
library(topicdoc)

# path for dataset
path_dataset <- paste("<filepath>.csv")
             
# read csv
textdata <- read.csv(path_dataset, header= T, sep = ";", encoding = "UTF-8")        

# change column name
colnames(textdata)[colnames(textdata) == "X.U.FEFF.File"] <- "Filenames"

# dimensions of dataframe
dim(textdata)

# detect duplicated cells -> delete in document
duplicated(textdata)

# new dimensions of dataframe
dim(textdata)

# create corpus
textdata_corpus <- corpus(textdata$Text, docnames = textdata$Filenames)

# calculate corpus tokens
corpus_tokens <- ntoken(textdata_corpus)
corpus_tokens_sum <- sum(data.frame(corpus_tokens))

# calculate corpus types
DTM <- dfm(textdata_corpus)
corpus_types <- dim(DTM)[2]

# import dictionary of lemmas
lemma_data <- read.csv(<filepath>, encoding = "UTF-8")

# remove lemmas "data, datum" and "electronic-data, electronic-datum"
lemma_data <- lemma_data[-c(10322,13618), ]

# import stopword list
stopword_data <- readLines(<filepath>, encoding = "UTF-8")

# create tokens object
corpus_tokens <- textdata_corpus %>%
  tokens(remove_punct = TRUE, remove_numbers = TRUE, remove_symbols = TRUE) %>% # remove punctuation, numbers and symbols
  tokens_tolower() %>% # transform tokens to only lowercase
  tokens_replace(lemma_data$inflected_form, lemma_data$lemma, valuetype = "fixed") %>% # lemmatization
  tokens_remove(pattern = stopword_data, padding = T) # remove stopwords

# find collocations
textdata_collocations <- textstat_collocations(corpus_tokens, min_count = 2)
# sort collocations by count
textdata_collocations_sorted <- textdata_collocations[order(-textdata_collocations$count), ]
# select all rows of sorted collocations
textdata_collocations <- textdata_collocations_sorted[1:273, ]
# insert collocations
corpus_tokens <- tokens_compound(corpus_tokens, textdata_collocations)

# create DTM
DTM <- corpus_tokens %>% 
  tokens_remove(c("", "big", "data", "big_data")) %>% # remove corpus-specific tokens
  dfm() %>% 
  dfm_trim(min_docfreq = 3, docfreq_type = "count") # pruning: remove terms that appear in less than 3 documents

# remove empty rows of DTM
sel_idx <- rowSums(DTM) > 0
DTM <- DTM[sel_idx, ]

# count tokens
DTM_tokens <- sum(ntoken(DTM))

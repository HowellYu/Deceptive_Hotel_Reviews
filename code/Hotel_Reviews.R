################################################################################
### Initialize environment
################################################################################
rm(list=ls())
library(tidyverse)
library(gridExtra) #viewing multiple plots together
library(tidytext) #text mining
library(wordcloud2) #creative visualizations
library(ggthemes)
library(moments)

library(knitr) # for dynamic reporting
library(kableExtra) # create a nicely formated HTML table
library(formattable) # for the color_tile function
# Cool example of format table
# formattable(mtcars, list(mpg = color_tile("yellow", "violet"),disp = color_tile("yellow", "violet")))

Project_Dir <- "/Users/amkhosla/Desktop/Statistics/Projects/Hotel_Reviews/code"
setwd(Project_Dir)

training_path = '../input/op_spam_train/'
training_files <- list.files(path=training_path, pattern="*.txt", full.names=TRUE, recursive=TRUE)
if (length(training_files) != 1600) { 
    stop (paste("Couldn't locate input training files at:",  
                print(getwd()), print(training_path)))
}
training.df <- as.tibble(as.data.frame(training_files, 
                                       col.names = c("Training_File"),
                                       stringsAsFactors = FALSE))

# label file as spam or not
spam_labels <- list()
spam_labels <- sapply(1:length(training_files), function(anIndex) spam_labels[anIndex] <- "truth")
spam_labels[grep("/deceptive", training_files, value = FALSE)] <- "deceptive"
training.df$Spam_Label <- spam_labels
View(training.df)

# Read reviews into data frame
training.df$Hotel_Reviews <- sapply(training_files, read_file)

###
# FIX CONTRACTIONS like won't can't, etc.
# function to expand contractions in an English-language source
fix.contractions <- function(doc) {
    # "won't" is a special case as it does not expand to "wo not"
    doc <- gsub("won't", "will not", doc)
    doc <- gsub("can't", "can not", doc)
    doc <- gsub("n't", " not", doc)
    doc <- gsub("'ll", " will", doc)
    doc <- gsub("'re", " are", doc)
    doc <- gsub("'ve", " have", doc)
    doc <- gsub("'m", " am", doc)
    doc <- gsub("'d", " would", doc)
    # 's could be 'is' or could be possessive: it has no expansion
    doc <- gsub("'s", "", doc)
    return(doc)
}
# function to remove special characters
removeSpecialChars <- function(x) gsub("[^a-zA-Z0-9 ]", " ", x)

# fix (expand) contractions
training.df$Filtered_Reviews <- sapply(training.df$Hotel_Reviews, fix.contractions)
# remove special characters
training.df$Filtered_Reviews <- sapply(training.df$Filtered_Reviews, removeSpecialChars)

tokenized_training.df <- training.df %>% 
    unnest_tokens(word, Filtered_Reviews) %>%
    anti_join(stop_words) %>%
    distinct() %>%
    filter(nchar(word) > 3)

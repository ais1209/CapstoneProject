suppressPackageStartupMessages(c(
library(shiny),
library(ggplot2),
library(pracma),
library(tm),
require(RWeka),
library(ngram),
library(dplyr),
library(plyr),
library(tau)
))

source("./word_prediction.R")
unigram.freq <- readRDS(file="unigram_prob_1percent.RDS")
bigram.freq <- readRDS(file="bigram_prob_1percent.RDS")
trigram.freq <- readRDS(file="trigram_prob_1percent.RDS")

shinyServer(    
    function(input, output) {
        
        prediction <- reactive({
            if(input$text1 == '' | input == 'NA'){
                prediction <- 'You have not typed anything yet!'
            } else {
                input.phrase <- tolower(input$text1)
                input.phrase <- gsub("[^A-Za-z ]","",input.phrase)
                input.phrase <- removePunctuation(input.phrase)
                input.phrase <- removeNumbers(input.phrase)
                input.phrase <- stripWhitespace(input.phrase)
                
                input.phrase<- unlist(strsplit(input.phrase," "))
                
                N <- length(input.phrase)
                if(N > 1) {
                    query <- paste(input.phrase[N-1], input.phrase[N])
                } else{
                    query <- input.phrase
                }
                
                if(N > 1) {
                    if(!is.na(f3(query)[1])) {
                        prediction <-  f3(query)
                    } else {
                        if(!is.na(f2(input.phrase[N]))){
                            prediction <- f2(input.phrase[N])
                        } else {
                            prediction <- unigram.freq$word.1[1]
                        }
                    } 
                }
                if (N == 1) {
                    if(!is.na(f2(query)[1])){
                        prediction <- f2(query)
                    } else{
                        prediction <- unigram.freq$word.1[1]
                    }
                }
            }   
            
            return(prediction)
        })
        output$text1 <- renderPrint(prediction())
        }
)

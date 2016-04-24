unigram.freq <- readRDS(file="unigram_prob_1percent.RDS")
bigram.freq <- readRDS(file="bigram_prob_1percent.RDS")
trigram.freq <- readRDS(file="trigram_prob_1percent.RDS")

f2 <- function(query, n = 1) {
    query <- tolower(query)
    idx <- which(bigram.freq$word.1 == query)
    res <- head(bigram.freq$word.2[idx], n)
    return(res)
}

f2_1 <- function(query, n = 1) {
    query <- tolower(query)
    idx <- which(bigram.freq$bigram == query)
    res <- head(bigram.freq$count[idx], n)
    return(res)
}

f3 <- function(query, n = 1) {
    query <- tolower(query)
    idx <- which(trigram.freq$word.1 == query)
    res <- head(trigram.freq$word.2[idx], n)
    return(res)
}


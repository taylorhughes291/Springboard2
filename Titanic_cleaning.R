library(dplyr)
library(tidyr)

titanic <- read.csv(file = "Documents/Springboard Files/Data Wrangling/Titanic/titanic_original.csv")
embarcos <- as.character(titanic[, "embarked"])

for(i in 1:length(embarcos)) {
  if(embarcos[i] == "") {
    embarcos[i] <- "S"
  }
}

titanic[, "embarked"] <- embarcos

meen <- mean(titanic[, "age"], na.rm = TRUE)
for(i in 1:length(titanic[, "age"])) {
  if(is.na(titanic[i, "age"])) {
    titanic[i, "age"] <- meen
  }
}

for(i in 1:length(titanic[, "boat"])) {
  if(titanic[i, "boat"] == "") {
    titanic[i, "boat"] <- NA
  }
}

titanic$has_cabin_number <- 0
for(i in 1: length(titanic[, "has_cabin_number"])) {
  if(titanic[i, "cabin"] == "") {
    titanic[i, "has_cabin_number"] <- 0
  } else {
    titanic[i, "has_cabin_number"] <- 1
  }
}

write.csv(titanic, file = "Documents/Springboard Files/Data Wrangling/Titanic/titanic_clean.csv")
nomenclature <- c("Observations", "Subject", "Activity ID", "Activity")


for(i in 1:128) {
  nomenclature <- c(nomenclature, paste("Total x Acceleration",i, sep = " "))  
}

for(i in 1:128) {
  nomenclature <- c(nomenclature, paste("Total y Acceleration",i, sep = " "))
}

for(i in 1:128) {
  nomenclature <- c(nomenclature, paste("Total z Acceleration",i, sep = " "))
}

for(i in 1:128) {
  nomenclature <- c(nomenclature, paste("Body Acceleration x",i, sep = " "))  
}

for(i in 1:128) {
  nomenclature <- c(nomenclature, paste("Body Acceleration y",i, sep = " "))
}

for(i in 1:128) {
  nomenclature <- c(nomenclature, paste("Body Acceleration z",i, sep = " "))
}

for(i in 1:128) {
  nomenclature <- c(nomenclature, paste("Body Gyro x",i, sep = " "))  
}

for(i in 1:128) {
  nomenclature <- c(nomenclature, paste("Body Gyro y",i, sep = " "))
}

for(i in 1:128) {
  nomenclature <- c(nomenclature, paste("Body Gyro z",i, sep = " "))
}

features <- as.character(features["text"])
features <- str_split(features, "\n")
features <- as.data.frame(features, stringsAsFactors = FALSE, col.names = c("Feature Name"))
features <- features %>% separate(Feature.Name, c("Number", "Name"), sep = " ")
features <- features[, "Name"]
nomenclature <- c(nomenclature, features)


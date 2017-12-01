library(dplyr)
library(tidyr)

refine <- read.csv(file = "Documents/Springboard Files/Data Wrangling/refine_original.csv")
mispell <- refine[,"company"]

mispell <- as.character(mispell)

for(i in 1:length(mispell)) {
  mispell[i] <- tolower(mispell[i])
}

for(i in 1:length(mispell)) {
  if(mispell[i] != "phillips" & mispell[i] != "akzo" & mispell[i] != "van houten" & mispell[i] != "unilever") {
      print(mispell[i])
      print(i)
  }
}

mispell[3] <- "phillips"
mispell[4] <- "phillips"
mispell[5] <- "phillips"
mispell[10] <- "akzo"
mispell[11] <- "akzo"
mispell[15] <- "phillips"
mispell[16] <- "phillips"
mispell[22] <- "unilever"

for(i in 1:length(mispell)) {
  if(mispell[i] == "phillips") {
    mispell[i] <- "Phillips"
  } else if(mispell[i] == "akzo") {
    mispell[i] <- "AKZO"
  } else if(mispell[i] == "van houten") {
    mispell[i] <- "Van Houten"
  } else {
    mispell[i] <- "Unilever"
  }
}

refine[,"company"] <- mispell

refine <- refine %>% separate(Product.code...number, c("product_code", "product_number"), sep = "-")

refine$product_category <- refine[,2]

pc <- refine[,"product_code"]

for(i in 1:length(pc)) {
  if(pc[i] == "p") {
    pc[i] <- "Smartphone"
  } else if(pc[i] == "v") {
    pc[i] <- "TV"
  } else if(pc[i] == "x") {
    pc[i] <- "Laptop"
  } else if(pc[i] == "q") {
    pc[i] <- "Tablet"
  } else {
    print(i)
    print(pc[i])
  }
  }

refine[, "product_category"] <- pc

refine <- refine %>% mutate(full_address = paste(address, ", ", city, ", ", country, sep = ""))

refine$company_phillips <- refine[, "company"]
refine$company_akzo <- refine[, "company"]
refine$company_van_houten <- refine[, "company"]
refine$company_unilever <- refine[, "company"]

bin_co <- function(x, com) {
  num <- 0
  if(com == "p" & x == "Phillips") {
    num <- 1
  } else if(com == "a" & x == "AKZO") {
    num <- 1
  } else if(com == "v" & x == "Van Houten") {
    num <- 1
  } else if(com == "u" & x == "Unilever") {
    num <- 1
  } 
  x <- num
}

refine[, "company_phillips"] <- sapply(mispell, bin_co, com = "p", USE.NAMES = FALSE)
refine[, "company_akzo"] <- sapply(mispell, bin_co, com = "a", USE.NAMES = FALSE)
refine[, "company_van_houten"] <- sapply(mispell, bin_co, com = "v", USE.NAMES = FALSE)
refine[, "company_unilever"] <- sapply(mispell, bin_co, com = "u", USE.NAMES = FALSE)

prodcatbase <- as.character(refine[, "product_category"])

refine$product_smartphone <- refine[, "product_category"]
refine$product_tv <- refine[, "product_category"]
refine$product_laptop <- refine[, "product_category"]
refine$product_tablet <- refine[, "product_category"]

bin_prod <- function(x, prod) {
  num <- 0
  if(prod == "s" & x == "Smartphone") {
    num <- 1
  } else if(prod == "tv" & x == "TV") {
    num <- 1
  } else if(prod == "l" & x == "Laptop") {
    num <- 1
  } else if(prod == "t" & x == "Tablet") {
    num <- 1
  } 
  x <- num
}

refine[, "product_smartphone"] <- sapply(prodcatbase, bin_prod, prod = "s", USE.NAMES = FALSE)
refine[, "product_tv"] <- sapply(prodcatbase, bin_prod, prod = "tv", USE.NAMES = FALSE)
refine[, "product_laptop"] <- sapply(prodcatbase, bin_prod, prod = "l", USE.NAMES = FALSE)
refine[, "product_tablet"] <- sapply(prodcatbase, bin_prod, prod = "t", USE.NAMES = FALSE)

print(refine)
write.csv(refine, file = "Documents/Springboard Files/Data Wrangling/refine_clean.csv", row.names = FALSE)
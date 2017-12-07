#Do not Paste the following

ActivityName <- NULL
y_train <- readtext("Documents/Springboard Files/Data Wrangling/Samsung Galaxy/UCI HAR Dataset/train/y_train.txt")
subject_train <- readtext("Documents/Springboard Files/Data Wrangling/Samsung Galaxy/UCI HAR Dataset/train/subject_train.txt")
total_acc_x_train <- readtext("Documents/Springboard Files/Data Wrangling/Samsung Galaxy/UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
X_train <- readtext("Documents/Springboard Files/Data Wrangling/Samsung Galaxy/UCI HAR Dataset/train/X_train.txt")

#Start Copy/Pasting Here


Observations <- c(1:7352)

NewlineV <- function(x) {
  x <- as.character(x["text"])
  x <- str_split(x, "\n")
  x <- unlist(x)
}

Subject <- NewlineV(subject_train)
ActivityLabel <- NewlineV(y_train)
for(i in 1:length(ActivityLabel)) {
    if(ActivityLabel[i] == 1) {
      x <- "Walking"
    } else if(ActivityLabel[i] == 2) {
      x <- "Walking Upstairs"
    } else if(ActivityLabel[i] == 3) {
      x <- "Walking Downstairs"
    } else if(ActivityLabel[i] == 4) {
      x <- "Sitting"
    } else if(ActivityLabel[i] == 5) {
      x <- "Standing"
    } else {
      x <- "Laying"
    }
    ActivityName <- c(ActivityName, x)
}

#You now have vectors of length 7352 for Observation, Subject, ActivityLabel, and ActivityName.

total_acc_x_train <- NewlineV(total_acc_x_train)
body_acc_x_train <- NewlineV(body_acc_x_train)
body_acc_y_train <- NewlineV(body_acc_y_train)
body_acc_z_train <- NewlineV(body_acc_z_train)
body_gyro_x_train <- NewlineV(body_gyro_x_train)
body_gyro_y_train <- NewlineV(body_gyro_y_train)
body_gyro_z_train <- NewlineV(body_gyro_z_train)
total_acc_y_train <- NewlineV(total_acc_y_train)
total_acc_z_train <- NewlineV(total_acc_z_train)

test_train <- NULL
for(i in 1:7352) {
  test_train <- c(test_train, "train")
}

#You now have vectors of length 7352 for all training Inertial Signals and the test/train specification.

X_train <- NewlineV(X_train)
X_train <- as.list(X_train)

Cmat <- str_split(X_train[[1]][1], " ")
Cmat <- unlist(Cmat)
Dmat <- NULL
for(i in 1:length(Cmat)) {
  if(Cmat[i] == "") {
   next
  } else {
   Dmat <- c(Dmat, Cmat[i]) 
  }
}
Emat <- matrix(Dmat, nrow = 1, ncol = 561)
z <- NULL

for(i in 2:length(X_train)) {
  x <- unlist(str_split(X_train[[i]][1], " "))
  for(p in 1:length(x)) {
    if(x[p] == "") {
      next
    } else {
      z <- c(z, x[p])
    }
  }
  Emat <- rbind(Emat, z)
  z <- NULL
}

#try to figure out why this loop doesn't work!!!
w <- NULL
for(i in 1:length(features)) {
  for(p in 1:length(7352)) {
    w <- c(w, Emat[p,i])
  }
  features[i] <- w
  w<- NULL
}

CDF <- data.frame(Observations, Subject, ActivityLabel, ActivityName, total_acc_x_train, total_acc_y_train, total_acc_z_train, body_acc_x_train, body_acc_y_train, body_acc_z_train, body_gyro_x_train, body_gyro_y_train, body_gyro_z_train)
for(i in 1:length(features)) {
  CDF <- data.frame(CDF, features[i])
}
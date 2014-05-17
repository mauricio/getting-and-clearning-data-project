library(plyr)

columnNumbers <- c(1, 2, 3, 4, 5, 6, 41, 42, 43, 44, 45, 46, 81, 82, 83, 84, 85, 86, 121, 122, 123, 124, 125, 126, 161, 162, 163, 164, 165, 166, 201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 266, 267, 268, 269, 270, 271, 345, 346, 347, 348, 349, 350, 424, 425, 426, 427, 428, 429, 503, 504, 516, 517, 529, 530, 542, 543)
columnNames <- c("BodyAcc_mean_X", "BodyAcc_mean_Y", "BodyAcc_mean_Z", "BodyAcc_std_X", "BodyAcc_std_Y", "BodyAcc_std_Z", "GravityAcc_mean_X", "GravityAcc_mean_Y", "GravityAcc_mean_Z", "GravityAcc_std_X", "GravityAcc_std_Y", "GravityAcc_std_Z", "BodyAccJerk_mean_X", "BodyAccJerk_mean_Y", "BodyAccJerk_mean_Z", "BodyAccJerk_std_X", "BodyAccJerk_std_Y", "BodyAccJerk_std_Z", "BodyGyro_mean_X", "BodyGyro_mean_Y", "BodyGyro_mean_Z", "BodyGyro_std_X", "BodyGyro_std_Y", "BodyGyro_std_Z", "BodyGyroJerk_mean_X", "BodyGyroJerk_mean_Y", "BodyGyroJerk_mean_Z", "BodyGyroJerk_std_X", "BodyGyroJerk_std_Y", "BodyGyroJerk_std_Z", "BodyAccMag_mean", "BodyAccMag_std", "GravityAccMag_mean", "GravityAccMag_std", "BodyAccJerkMag_mean", "BodyAccJerkMag_std", "BodyGyroMag_mean", "BodyGyroMag_std", "BodyGyroJerkMag_mean", "BodyGyroJerkMag_std", "BodyAcc_mean_X", "BodyAcc_mean_Y", "BodyAcc_mean_Z", "BodyAcc_std_X", "BodyAcc_std_Y", "BodyAcc_std_Z", "BodyAccJerk_mean_X", "BodyAccJerk_mean_Y", "BodyAccJerk_mean_Z", "BodyAccJerk_std_X", "BodyAccJerk_std_Y", "BodyAccJerk_std_Z", "BodyGyro_mean_X", "BodyGyro_mean_Y", "BodyGyro_mean_Z", "BodyGyro_std_X", "BodyGyro_std_Y", "BodyGyro_std_Z", "BodyAccMag_mean", "BodyAccMag_std", "BodyBodyAccJerkMag_mean", "BodyBodyAccJerkMag_std", "BodyBodyGyroMag_mean", "BodyBodyGyroMag_std", "BodyBodyGyroJerkMag_mean", "BodyBodyGyroJerkMag_std")
maxRows <- -1

activityLabels <- read.table( "uci-har/activity_labels.txt", stringsAsFactors=FALSE )

readData <- function( dataType ) {  
  xPath <- paste0("uci-har/", dataType, "/X_", dataType, ".txt")
  yPath <- paste0("uci-har/", dataType, "/Y_", dataType, ".txt")
  subjectPath <- paste0("uci-har/", dataType, "/subject_", dataType, ".txt")
  fullData <- read.table(xPath, sep="", stringsAsFactors=FALSE, nrows=maxRows)[,columnNumbers]
  yData <- read.table(yPath, nrows=maxRows,col.names=c("number"))    
  subjectData <- read.table(subjectPath, nrows=maxRows,col.names=c("subject"))
  colnames(fullData) <- columnNames
  fullData$activity <- activityLabels[yData$number,2]
  fullData$subject <- subjectData$subject
  fullData
}

readTrainData <- function() {
  readData("train")
}

readTestData <- function() {
  readData("test")
}

readAll <- function() {
  rbind(readTrainData(), readTestData())
}

produceTidy <- function() {
  all <- readAll()
  process <- function (rows) {
    colMeans(rows[,1:66])
  }
  ddply( all, .(activity, subject), process )
}

tidy <- produceTidy()

write.table(tidy, "tidy.txt", sep=",")
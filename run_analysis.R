library(reshape2)

setwd("~/Dropbox/Coursera/R codes/03_Getting_Cleaning Data")

## Download the zipped data and unzip it
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
fileName <- 'dataset.zip'
    
download.file(fileUrl, destfile = fileName, method = 'curl')
unzip(fileName)

featureDF <- read.table("./UCI HAR Dataset/features.txt")

## Get the measurements on the mean and standard deviation
featureDF1 <- grep("(mean|std)[(]",featureDF[,2], value=T)

## Import Training Datasets & peform Feature Selections
trainIDdf <- read.table("./UCI HAR Dataset/train/subject_train.txt")
trainXdf  <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainYdf  <- read.table("./UCI HAR Dataset/train/y_train.txt")

names(trainIDdf) <- "id"
names(trainXdf) <- featureDF[,2]
names(trainYdf) <- "labels"
trainXdf1 <- trainXdf[, names(trainXdf) %in% featureDF1]
trainDF <- cbind(trainIDdf, trainXdf1, trainYdf)

rm(trainIDdf, trainXdf, trainYdf, trainXdf1)

## Import Test Datasets & perform Feature Selections
testIDdf <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testXdf  <- read.table("./UCI HAR Dataset/test/X_test.txt")
testYdf  <- read.table("./UCI HAR Dataset/test/y_test.txt")


names(testIDdf) <- "id"
names(testXdf) <- featureDF[,2]
names(testYdf) <- "labels"

testXdf1 <- testXdf[, names(testXdf) %in% featureDF1]
testDF <- cbind(testIDdf, testXdf1, testYdf)

rm(testIDdf, testXdf, testYdf, testXdf1)

fullDF <- rbind(trainDF, testDF)
rm(trainDF, testDF)

activityDF <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activityDF) <- c("labels", "activityDesc")

## Check column names and create merged Data Frame
intersect(names(fullDF), names(activityDF))
mergedDF <-merge(fullDF,activityDF, by="labels", all=T)
mergedDF1 <- subset(mergedDF, select = -labels)

## Create tidy data frame and export to flat file 
meltDF <- melt(mergedDF1, id=c("activityDesc", "id"), na.rm=T)
tidyDF <- dcast(meltDF, activityDesc + id ~ variable, mean)

write.table(tidyDF, file="tidy_dataset.txt")

rm(mergedDF, mergedDF1, meltDF)


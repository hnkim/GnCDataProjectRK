getwd()
setwd("~/Dropbox/Coursera/R codes/03_Getting_Cleaning Data")

# list.files("./proj_dataset/train")
# list.files("./proj_dataset/test")

featureDF <- read.table("./proj_dataset/features.txt")
head(featureDF)

## Import Training Datasets
trainXdf <- read.table("./proj_dataset/train/X_train.txt")
trainYdf <- read.table("./proj_dataset/train/y_train.txt")

## Import Test Datasets
testXdf <- read.table("./proj_dataset/test/X_test.txt")
testYdf <- read.table("./proj_dataset/test/y_test.txt")

names(trainXdf) <- featureDF[,2]
# names(trainXdf)

names(testXdf) <- featureDF[,2]
# names(testXdf)

names(trainYdf) <- "labels"
names(testYdf) <- "labels"

trainDF <- cbind(trainXdf, trainYdf)
testDF <- cbind(testXdf, testYdf)

fullDF <- rbind(trainDF, testDF)

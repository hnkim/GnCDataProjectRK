getwd()
setwd("~/Dropbox/Coursera/R codes/03_Getting_Cleaning Data")

# list.files("./proj_dataset/train")
# list.files("./proj_dataset/test")

featureDF <- read.table("./proj_dataset/features.txt")
head(featureDF)

featureDF1 <- grep(".(mean|std).",featureDF[,2], value=T)
featureDF1

## Import Training Datasets & Feature Selection
trainIDdf <- read.table("./proj_dataset/train/subject_train.txt")
trainXdf <- read.table("./proj_dataset/train/X_train.txt")
trainYdf <- read.table("./proj_dataset/train/y_train.txt")

names(trainIDdf) <- "id"
names(trainXdf) <- featureDF[,2]
names(trainYdf) <- "labels"
trainXdf1 <- trainXdf[, names(trainXdf) %in% featureDF1]
trainDF <- cbind(trainIDdf, trainXdf1, trainYdf)

rm(trainIDdf, trainXdf, trainYdf, trainXdf1)

## Import Test Datasets & Feature Selection
testIDdf <- read.table("./proj_dataset/test/subject_test.txt")
testXdf <- read.table("./proj_dataset/test/X_test.txt")
testYdf <- read.table("./proj_dataset/test/y_test.txt")


names(testIDdf) <- "id"
names(testXdf) <- featureDF[,2]
names(testYdf) <- "labels"

testXdf1 <- testXdf[, names(testXdf) %in% featureDF1]
testDF <- cbind(testIDdf, testXdf1, testYdf)

rm(testIDdf, testXdf, testYdf, testXdf1)

fullDF <- rbind(trainDF, testDF)
rm(trainDF, testDF)

activityDF <- read.table("./proj_dataset/activity_labels.txt")
names(activityDF) <- c("labels", "activityDesc")

# check column names and create merged Data Frame
intersect(names(fullDF), names(activityDF))
mergedDF <-merge(fullDF,activityDF, by="labels", all=T)
mergedDF1 <- subset(mergedDF, select = -labels)

# create tidy data frame 
library(reshape2)
meltDF <- melt(mergedDF1, id=c("activityDesc", "id"), na.rm=T)
str(meltDF)

tidyDF <- dcast(meltDF, activityDesc + id ~ variable, mean)

write.table(tidyDF, file="tidy_dataset.txt")


## Getting and Cleaning Data Project

This repo contains project code and files for `Getting and Cleaning Data` 
course as part of my data science specializations by John Hopkins University on Coursera.

### R Script 

The script (`run_analysis.R`) performs the following jobs;

- downloads the zip file from the source and unzip the files to local directory
- merges the training and the test sets to create one data set.
- extracts only the measurements on the mean and standard deviation for each measurement. 
- uses descriptive activity names to name the activities in the data set
- appropriately labels the data set with descriptive variable names. 
- creates a tidy data set with the average of each variable for each activity and each subject. 
- writes the tidy data set to `tidy_dataset.txt`


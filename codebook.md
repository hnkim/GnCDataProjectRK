## The Raw Data
The R script includes the steps to download zip file and from the below link;
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>


## Full Data Set

In order to extract only the measurements on the mean and standard deviation for 
the following regular expression was used: `(mean|std)[(]` 

The full data set(`full_dataset.txt`) contains  10,299 obs with 68 variables;

- `activityDesc` - An activity label.
- `id` - An identifier of the subject who carried out the experiment.
 
Plus 66 filtered features as described above.

The following is the variable lists for the full dataset.

1	activityDesc
2	id
3	tBodyAcc-mean()-X
4	tBodyAcc-mean()-Y
5	tBodyAcc-mean()-Z
6	tBodyAcc-std()-X
7	tBodyAcc-std()-Y
8	tBodyAcc-std()-Z
9	tGravityAcc-mean()-X
10	tGravityAcc-mean()-Y
11	tGravityAcc-mean()-Z
12	tGravityAcc-std()-X
13	tGravityAcc-std()-Y
14	tGravityAcc-std()-Z
15	tBodyAccJerk-mean()-X
16	tBodyAccJerk-mean()-Y
17	tBodyAccJerk-mean()-Z
18	tBodyAccJerk-std()-X
19	tBodyAccJerk-std()-Y
20	tBodyAccJerk-std()-Z
21	tBodyGyro-mean()-X
22	tBodyGyro-mean()-Y
23	tBodyGyro-mean()-Z
24	tBodyGyro-std()-X
25	tBodyGyro-std()-Y
26	tBodyGyro-std()-Z
27	tBodyGyroJerk-mean()-X
28	tBodyGyroJerk-mean()-Y
29	tBodyGyroJerk-mean()-Z
30	tBodyGyroJerk-std()-X
31	tBodyGyroJerk-std()-Y
32	tBodyGyroJerk-std()-Z
33	tBodyAccMag-mean()
34	tBodyAccMag-std()
35	tGravityAccMag-mean()
36	tGravityAccMag-std()
37	tBodyAccJerkMag-mean()
38	tBodyAccJerkMag-std()
39	tBodyGyroMag-mean()
40	tBodyGyroMag-std()
41	tBodyGyroJerkMag-mean()
42	tBodyGyroJerkMag-std()
43	fBodyAcc-mean()-X
44	fBodyAcc-mean()-Y
45	fBodyAcc-mean()-Z
46	fBodyAcc-std()-X
47	fBodyAcc-std()-Y
48	fBodyAcc-std()-Z
49	fBodyAccJerk-mean()-X
50	fBodyAccJerk-mean()-Y
51	fBodyAccJerk-mean()-Z
52	fBodyAccJerk-std()-X
53	fBodyAccJerk-std()-Y
54	fBodyAccJerk-std()-Z
55	fBodyGyro-mean()-X
56	fBodyGyro-mean()-Y
57	fBodyGyro-mean()-Z
58	fBodyGyro-std()-X
59	fBodyGyro-std()-Y
60	fBodyGyro-std()-Z
61	fBodyAccMag-mean()
62	fBodyAccMag-std()
63	fBodyBodyAccJerkMag-mean()
64	fBodyBodyAccJerkMag-std()
65	fBodyBodyGyroMag-mean()
66	fBodyBodyGyroMag-std()
67	fBodyBodyGyroJerkMag-mean()
68	fBodyBodyGyroJerkMag-std()

## Tidy Data Set
 
The tidy data set(`tidy_dataset.txt`) is created from the full dataset(`full_dataset.txt`)
by taking with the average of each variable for each activity and each subject.

It contains 180 obs with 68 variables and variables names are the same as full dataset.

In order to summarize the dataset the following method was used and both the `melt()` and `dcast()`
function require `reshape2` package.

```r
## Create tidy data frame  
meltDF <- melt(mergedDF1, id=c("activityDesc", "id"), na.rm=T)
tidyDF <- dcast(meltDF, activityDesc + id ~ variable, mean)



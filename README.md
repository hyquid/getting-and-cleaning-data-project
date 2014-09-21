getting-and-cleaning-data-project
=================================
##Things to prepare:
##set up the working directory
##read in the test and train sets
##after reading in the test and train sets, should check the dimension of the dataset

##step1 combine the test set and train set
##combine test set and train set

##step2 extract the mean() and std() columns
## The original dataset has 561 features (columns) and they are corresponding to the 561 rows in the "features.txt" file. So, find out which rows contain "mean()" or "std()" in features.txt file will help to find out which columns in "dataset" are for the means and standard deviations
## Read in the features.txt as "feature"
## Extract the rows with "mean()" and "std()" in the second column of the dataset "feature"
## find out the row names of the extracted rows , they are still in "character"
## convert the row names into numeric
## Lastly, using the numeric "rowname" vector to extract the measurements on only "mean()" and "std()" for each measurement

##Step3 Uses descriptive activity names to name the activities in the data set
## this is actually adding the row names for the dataset
## dataset has 10299 observations, the first 2947 of which are from test set and
## remaining 7352 from the train set (see the order they are in the rbind()).
## Therefore, using rbind() to bind the labels of the test set and train set 
## in the same order how test_set and train_set are bound.
## First, read in the label files "y_test.txt" and "y_train.txt"
## then, rbind the actvity_test and activity_train
## Now allactivity contains 1-6 which indicate six different activity:
## 1 WALKING
## 2 WALKING_UPSTAIRS
## 3 WALKING_DOWNSTAIRS
## 4 SITTING
## 5 STANDING
## 6 LAYING
## Add the descriptive lables using "if else" function
##Since the descriptive name is displayed for each catogory (1~6),
##the second column $activityname will be added to "dataset"

##step4 Appropriately labels the data set with descriptive variable names
## This is actually to add column names for column V1 to V561 in the "newdataset"
## First, need to read in the "new features.txt" which replaces the "()" and "," with "" 
## and replaces "-" with "_", the elements in the "features.txt"
## is actually the column names for the "newdataset"
## Name the dataset as "features2"
## Now, look at the structure of features2 and find out that the second column
## is the vector we need.
## rename the column names of V1 to V561 in the "newdataset"

##step5 5.  Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
##First need to add the subject info to the "newdataset"
##Read in the subject files
##add the subjects info to "newdataset"
## Need to use plyr library now to do the summary and create that tidy file
##write dataset as txt file 

##set up the working directory
setwd("~/coursera/Cleaning data/project/step1 merge training and test sets")

##read in the test and train sets
test_set<-read.table("X_test.txt")
train_set<-read.table("X_train.txt")

##try to know the dimension of the test and train sets
dim(test_set)
dim(train_set)

##step1 combine the test set and train set
##combine test set and train set
dataset<-rbind(test_set,train_set)


##step2 extract the mean() and std() columns
## The original dataset has 561 features (columns) and they are corresponding to
## the 561 rows in the "features.txt" file. So, find out which rows contain "mean()"
## or "std()" in features.txt file will help to find out which columns in "dataset"
## are for the means and standard deviations
##read in the features.txt
features<-read.table("features.txt",colClasses = "character", sep="-",,strip.white=T,blank.lines.skip=T,fill=T)
##extract the rows with "mean()" and "std()" in the second column
extrfeatures<-features[features[,2]=="mean()"|features[,2]=="std()",]
##find out the row names of the extracted rows , they are still in "character"
rowname<-rownames(extrfeatures)
## convert the row names into numeric
rowname<-as.numeric(rowname)
## Lastly, using the numeric "rowname" vector to extract the measurements on only "mean()"
## and "std()" for each measurement
extrdataset<-dataset[,rowname]

##Step3 Uses descriptive activity names to name the activities in the data set
## this is actually adding the row names for the dataset
## dataset has 10299 observations, the first 2947 of which are from test set and
## remaining 7352 from the train set (see the order they are in the rbind()).
## Therefore, using rbind() to bind the labels of the test set and train set 
## in the same order how test_set and train_set are bound.
## First, read in the label files "y_test.txt" and "y_train.txt"
actvity_test<-read.table("y_test.txt",colClasses="character")
actvity_train<-read.table("y_train.txt",colClasses="character")
##rbind the actvity_test and activity_train
allactivity<-rbind(actvity_test,actvity_train)
## Now allactivity contains 1-6 which indicate six different activity:
## 1 WALKING
## 2 WALKING_UPSTAIRS
## 3 WALKING_DOWNSTAIRS
## 4 SITTING
## 5 STANDING
## 6 LAYING
## Add the descriptive lables using if-else
allactivity$V1<-as.numeric(allactivity$V1)
for (i in 1:10299){
   if(allactivity$V1[i] == 1){
      allactivity$activityname[i] <- "WALKING"
   } 
   else if(allactivity$V1[i] == 2){
     allactivity$activityname[i] <- "WALKING_UPSTAIRS"
   } 
   else if(allactivity$V1[i] == 3){
      allactivity$activityname[i] <- "WALKING_DOWNSTAIRS"
   } 
   else if(allactivity$V1[i] == 4){
      allactivity$activityname[i] <- "SITTING"
   } 
   else if(allactivity$V1[i] == 5){
      allactivity$activityname[i] <- "STANDING"
   } 
   else if(allactivity$V1[i] == 6){
      allactivity$activityname[i] <- "LAYING"
   } 
}
##Since the descriptive name is displayed for each catogory (1~6),
##the second column $activityname will be added to "dataset"
newdataset <- cbind(allactivity$activityname,dataset)

##step4 Appropriately labels the data set with descriptive variable names
## This is actually to add column names for column V1 to V561 in the "newdataset"
## First, need to read in the "new features.txt" which replaces the "()" and "," with "" 
## and replaces "-" with "_", the elements in the "features.txt"
## is actually the column names for the "newdataset"
features2<-read.table("new features.txt",colClasses = "character")
## Now, look at the structure of features2 and find out that the second column
## is the vector we need.
## rename the column names of V1 to V561 in the "newdataset"
colnames(newdataset)[1:562]<-c("Activity_Name", features2$V2)

##step5 5.  Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
##First need to add the subject info to the "newdataset"
##Read in the subject files
test_subjects<-read.table("subject_test.txt",colClasses="character")
train_subjects<-read.table("subject_train.txt",colClasses="character")
all_subjects<-rbind(test_subjects,train_subjects)
##add the subjects info to "newdataset"
mydata<-cbind(all_subjects,newdataset)
colnames(mydata)[1]<-"Subject"
library(plyr)
summary<-ddply(mydata, .(Subject,Activity_Name),numcolwise(mean))
##write data as txt file 
write.table(summary, file="result.txt",row.names = FALSE)

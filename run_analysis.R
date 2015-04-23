# Coursera Getting and Cleaning Data (getdata-013)
# Course Project
# April 2015
# Author: Kim Kyllesbech Larsen
# Email: kim.k.larsen@hotmail.com
#
# R script to load & tidy the UCI HAR dataset
# dataset source https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#RETRIEVE UCI HAR (HUMAN ACTIVITY RECOGNITION)DATASET
##Define UCI HAR Dataset directory

uci.harDir <- "./UCI HAR Dataset" #this is the directory where all data is to be found

##unzip UCI HAR data files unless the uci_har_dir already exists

if (file.exists(uci.harDir) == FALSE) {
        
        t <- tempfile()
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" #Projects link to UCI HAR data file
        
        download.file(fileUrl, t, mode = "wb")
        
        unzip(t)
        unlink(t)
}

#RESULTS DIRECTORY
##Create a directory "results" where resulting files can be stored 

resultsDir <- "./results"
if (file.exists(resultsDir) == FALSE) dir.create(resultsDir)

#CONSTANTS & DEFINITIONS
##UCI HAR dataset files: names & locations

activity.file <- file.path(uci.harDir, "activity_labels.txt")
activity <- read.table(activity.file, h=FALSE)
names(activity)[1] <- "Label"
names(activity)[2] <- "Activity"                       #File containing the mapping of Label (i.e., y-files) with given Activity (e.g., Walk, Sitting, etc).

header.file <- file.path(uci.harDir, "./features.txt") #File containing type of measurements corresponding to x-files.
headData <- read.table(header.file, h=FALSE)

subj.testFile <- file.path(uci.harDir, "./test/subject_test.txt")      #Subject carrying out Activity
y.testFile <- file.path(uci.harDir, "./test/y_test.txt")              #Labeled Activity
x.testFile <- file.path(uci.harDir, "./test/X_test.txt")              #Activity-based Measurements

subj.trainFile <- file.path(uci.harDir, "./train/subject_train.txt")
y.trainFile <- file.path(uci.harDir, "./train/y_train.txt")
x.trainFile <- file.path(uci.harDir, "./train/X_train.txt")

#RETRIEVE THE DATA FROM THE UCI HAR DATASET
## Test Data Set:
## load test subjects id data
## load test activity labels y
## add headers to x test data

subj.testData <- read.table(subj.testFile, h=FALSE)

names(subj.testData) <- "Subject"

y.testData <- read.table(y.testFile, h=FALSE)
names(y.testData) <- "Label"

x.testData <- read.table(x.testFile, h=FALSE)
names(x.testData) <- headData[, 2]

## Train Data Set:
## load train subjects id data
## load train activity labels y
## add headers to x train data

subj.trainData <- read.table(subj.trainFile, h=FALSE)
names(subj.trainData) <- "Subject"

y.trainData <- read.table(y.trainFile, h=FALSE)
names(y.trainData) <- "Label"

x.trainData <- read.table(x.trainFile, h=FALSE)
names(x.trainData) <- headData[, 2]


#DATA RESHAPING & TIDYING

x.testData <- cbind(subj.testData, x.testData)
x.trainData <- cbind(subj.trainData, x.trainData)

## Append train to test to data (i.e., test data first and then after comes the train data)

x.data <- rbind(x.testData, x.trainData)
y.data <- rbind(y.testData, y.trainData)

## This writes a csv file format with including

write.csv(x.data, "./results/test&train_data.csv")  #Project task #1

yx.data <- cbind(y.data, x.data)

len <- length(yx.data[, 1])

activityData <- data.frame(1:len, 1)
activityData <- activity[yx.data[, 1], 2]

totalData <- cbind(activityData, yx.data)
names(totalData)[1]<-"Activity"

# write.csv(totalData, "./results/total_data_descriptive.csv") #Project tasks #1 enriched

### print("Total data file (ex: row 1-5 & col 1-6);")
### print(totalData[1:5,1:8])

#DATA SUBSET ONLY CONTAINING MEAN & STANDARD DEVIATION (STD) MEASUREMENTS

mean.col <- grep("mean", names(x.data)) #finding subset of data categorized as mean
std.col <- grep("std", names(x.data)) #finding subset of data categorized as std (i.e., standard deviation)

mean.std.data <- cbind(x.data[mean.col], x.data[std.col])
write.csv(mean.std.data, "./results/mean_std_data.csv") #Project task #2

### print("Measurements on the mean and standard deviation for each measurement (ex: row 1-5 & col 1-6);")
### print(mean_std.data[1:5,1:6])

mean.std.xtra <- cbind(totalData[, 3], mean.std.data); names(mean.std.xtra)[1] <- names(totalData)[3] #adding back Subject
mean.std.xtra <- cbind(totalData[, 2], mean.std.xtra); names(mean.std.xtra)[1] <- names(totalData)[2] #adding back Subject
mean.std.xtra <- cbind(totalData[, 1], mean.std.xtra); names(mean.std.xtra)[1] <- names(totalData)[1] #adding back descriptive Activity

# write.csv(mean.std.xtra, "./results/mean_std_descriptive.csv") #Project task #3 & #4 enriched with descriptive data

### print("Appropriately labeled data set with descriptive variable names (ex: row 1-5 & col 1-6);")
### print(mean_std.xtra[1:5,1:6])

# WRITING PROJECT SPECIFIED TIDY FILE
## Apply the mean to all measurements for the Subjects and their related Activities.
## Final Tidy up of data and showing the mean values only once mean per subject and per activity

len <- length(mean.std.xtra)
tmsx <- aggregate(mean.std.xtra[, 4:len], list(mean.std.xtra$Subject, mean.std.xtra$Activity), mean)

tidy.mean <- tmsx
tidy.mean[, 1] <- tmsx[, 2] #re-arranging columns so Subject is 2nd column
tidy.mean[, 2] <- tmsx[, 1] #re-arranging columns so Activity is 1st column

names(tidy.mean)[1:2] <- c("Activity","Subject")
write.table(tidy.mean,"./results/tidy_mean.txt",row.names=FALSE)

print("Tidy data set with the average of each variable for each activity and each subject (ex: row 25-35 & col 1-6);")
print(tidy.mean[25:35, 1:6])


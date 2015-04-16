# Coursera Getting and Cleaning Data (getdata-013)
# Course Project
# April 2014
# Author: Kim Kyllesbech Larsen
# Email: kim.k.larsen@hotmail.com
#
# R script to load & tidy the UCI HAR dataset
# dataset source https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Define UCI HAR Dataset directory

uci_har_dir <-"./UCI HAR Dataset" #this is the directory where all data is to be found

#unzip UCI HAR data files. If the directory "./UCI HAR Dataset" exist it will jump over this step and continue.

if (file.exists(uci_har_dir)==FALSE) {
          
          t <- tempfile()
          fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" #Projects link to UCI HAR data file
          
          download.file(fileUrl,t,mode="wb")
          
          unzip(t)
          unlink(t)
}

#Data files: names & locations

activity_file <- file.path(uci_har_dir,"activity_labels.txt")
activity <- read.table(activity_file,h=FALSE)
names(activity)[1] <- "Label"
names(activity)[2] <- "Activity"                       #File containing the mapping of Label (i.e., y-files) with given Activity (e.g., Walk, Sitting, etc).

header_file <- file.path(uci_har_dir,"./features.txt") #File containing type of measurements corresponding to x-files.
head_data <- read.table(header_file,h=FALSE)

subj_test_file <-file.path(uci_har_dir,"./test/subject_test.txt")      #Subject carrying out Activity
y_test_file <- file.path(uci_har_dir,"./test/y_test.txt")              #Labeled Activity
x_test_file <- file.path(uci_har_dir,"./test/X_test.txt")              #Activity-based Measurements

subj_train_file <-file.path(uci_har_dir,"./train/subject_train.txt")
y_train_file <- file.path(uci_har_dir,"./train/y_train.txt")
x_train_file <- file.path(uci_har_dir,"./train/X_train.txt")


#Create a directory "results" where resulting files can be stored 
results_dir <- "./results"

if (file.exists(results_dir)==FALSE) dir.create(results_dir)

# Test Data Set:
#1. add headers to x test data

subj_test_data <- read.table(subj_test_file,h=FALSE)
names(subj_test_data) <- "Subject"
x_test_data <- read.table(x_test_file,h=FALSE)
names(x_test_data) <- head_data[,2]

x_test_data <- cbind(subj_test_data,x_test_data)

# Train Data Set:
#1. add headers to x train data

subj_train_data <- read.table(subj_train_file,h=FALSE)
names(subj_train_data) <- "Subject"
x_train_data <- read.table(x_train_file,h=FALSE)
names(x_train_data) <- head_data[,2]

x_train_data <- cbind(subj_train_data,x_train_data)

#4. append train to test to data (i.e., test data first and then after comes the train data)
#   Write the full file to "results" directory as .csv file. 

x_data <- rbind(x_test_data,x_train_data)

#This writes a csv file format with including
#Coloumn 1: Subject
#Coloumn 2... :Measurement data contained in x-files.
#Descriptive Headers added for each of the measurement coloumns (i.e., Features-file)

write.csv(x_data,"./results/test&train_data.csv")                                       #Project task #1

#Adding numric & descriptive activity labels to the data;

y_test_data <- read.table(y_test_file,h=FALSE)
names(y_test_data) <- "Label"
y_train_data <- read.table(y_train_file,h=FALSE)
names(y_train_data) <- "Label"
y_data <- rbind(y_test_data,y_train_data)

yx_data <- cbind(y_data,x_data)

len <- length(yx_data[,1])

activity_data <- data.frame(1:len,1)
activity_data <- activity[yx_data[,1],2]

total_data <- cbind(activity_data,yx_data)
names(total_data)[1]<-"Activity"

write.csv(total_data,"./results/total_data_descriptive.csv")                          #Project tasks #1 enriched

print("Total data file (ex: row 1-5 & col 1-6);")
print(total_data[1:5,1:8])

#5 find data columns of categorized as mean and standard deviation (i.e., std)
mean_col <- grep("mean",names(x_data)) #finding subset of data categorized as mean
std_col <- grep("std",names(x_data)) #finding subset of data categorized as std (i.e., standard deviation)

mean_std_data <- cbind(x_data[mean_col],x_data[std_col],type="left")
write.csv(mean_std_data,"./results/mean_std_data.csv")                                #Project task #2

print("Measurements on the mean and standard deviation for each measurement (ex: row 1-5 & col 1-6);")
print(mean_std_data[1:5,1:6])

mean_std_xtra <- cbind(total_data[,3],mean_std_data);names(mean_std_xtra)[1]<-names(total_data)[3] #adding back Subject
mean_std_xtra <- cbind(total_data[,2],mean_std_xtra);names(mean_std_xtra)[1]<-names(total_data)[2] #adding back numeric activity id
mean_std_xtra <- cbind(total_data[,1],mean_std_xtra);names(mean_std_xtra)[1]<-names(total_data)[1] #adding back descriptive activity

write.csv(mean_std_xtra,"./results/mean_std_descriptive.csv")                         #Project task #3 & #4 enriched with descriptive data

print("Appropriately labeled data set with descriptive variable names (ex: row 1-5 & col 1-6);")
print(mean_std_xtra[1:5,1:6])

#6 FInal Tidy up of data

len <- length(mean_std_xtra)
tmsx <-aggregate(mean_std_xtra[,4:(len-1)],list(mean_std_xtra$Subject,mean_std_xtra$Activity),mean)

tidy_mean_std <- tmsx
tidy_mean_std[,1] <- tmsx[,2] #re-arranging columns so Subject is 2nd column
tidy_mean_std[,2] <- tmsx[,1] #re-arranging columns so Activity is 1st column

names(tidy_mean_std)[1:2] <- c("Activity","Subject")
write.table(tidy_mean_std,"./results/tidy_mean&std.txt",row.names=FALSE)

print("Tidy data set with the average of each variable for each activity and each subject (ex: row 25-35 & col 1-6);")
print(tidy_mean_std[28:33,1:6])

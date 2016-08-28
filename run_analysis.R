##############################################################################################
#
# This script does the following:
# 
# 1. Merge training and test sets and create one data set.
# 2. Extract the measurements on the mean and standard deviation for each measurement.
# 3. Use descriptive variable names to name the activities in the data set
# 4. Label the data set with descriptive variable names.
# 5. Creates a second independent tidy data set with average of each variable for each activity and subject.
#
##############################################################################################

# Set working directory
setwd("~/Coursera/Getting and Cleaning Data/Week4")

# Load feature names
features <- read.table("~/Coursera/Getting and Cleaning Data/Week4/UCI HAR Dataset/features.txt")
features <- features$V2

# Load training and test data
training <- read.table("~/Coursera/Getting and Cleaning Data/Week4/UCI HAR Dataset/train/X_train.txt")
colnames(training) <- features
testing <- read.table("~/Coursera/Getting and Cleaning Data/Week4/UCI HAR Dataset/test/X_test.txt")
colnames(testing) <- features

# Load subject number
subject_training <- read.table("~/Coursera/Getting and Cleaning Data/Week4/UCI HAR Dataset/train/subject_train.txt")
colnames(subject_training) <- "subject_no"
subject_testing <- read.table("~/Coursera/Getting and Cleaning Data/Week4/UCI HAR Dataset/test/subject_test.txt")
colnames(subject_testing) <- "subject_no"

# Load activity labels
activity_training <- read.table("~/Coursera/Getting and Cleaning Data/Week4/UCI HAR Dataset/train/y_train.txt")
colnames(activity_training) <- "activity"
activity_testing <- read.table("~/Coursera/Getting and Cleaning Data/Week4/UCI HAR Dataset/test/y_test.txt")
colnames(activity_testing) <- "activity"

##########################################
# Merge datasets (step 1)
##########################################
# Merge all components of training and testing, respectively
training <- cbind(subject_training,activity_training,training)
testing <- cbind(subject_testing,activity_testing,testing)

# Combine training and testing
full_dataset <- rbind(training,testing)

##########################################
# Get mean and standard deviation only (step 2)
##########################################
# Get column indices of the mean and std columns
mean_idx <- which(grepl("mean",colnames(full_dataset)))
stddev_idx <- which(grepl("std",colnames(full_dataset)))
mean_and_stddev_idx <- c(mean_idx,stddev_idx)

# Extract those columns
mean_and_stddev_measurements <- full_dataset[,c(1,2,mean_and_stddev_idx)]

##########################################
# Name activities (step 3)
##########################################
# Load activity names
activity_labels <- read.table("~/Coursera/Getting and Cleaning Data/Week4/UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("id","activity_label")

# Replace activity number by label name
mean_and_stddev_measurements$activity <- sapply(mean_and_stddev_measurements$activity,function(x){return(activity_labels$activity_label[x])})

##########################################
# Name features (step 4)
##########################################
# Has been taken care of in line 29, 31, 35 and 37 prior to step 1.

##########################################
# Aggregate to mean within each subject (step 5)
##########################################
# Initialize output data frame
output <- data.frame()

# Go through all combinations of subject id and activity code, find the relevant lines and determine mean
for (subj in 1:30){
  for (act in 1:6){
    this_idx <- which(mean_and_stddev_measurements$subject_no==subj & mean_and_stddev_measurements$activity==activity_labels$activity_label[act])
    
    output <- rbind(output,c(subj, activity_labels$activity_label[act], colMeans(mean_and_stddev_measurements[this_idx,3:ncol(mean_and_stddev_measurements)])))
  }
}

# Adjust column names
colnames(output) <- colnames(mean_and_stddev_measurements)

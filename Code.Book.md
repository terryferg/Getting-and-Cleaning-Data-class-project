---
title: "Code.Book.md"

##### This is the required code book for Getting and Cleaning Data Course Project 
##### Student: Terry Ferg
##### April, 2017


#### Overview
##### This Code Book describes the variables and the data transformations used to create the tidy dataset cellphone.accelerometer.tidy.data.csv prepared for this class project.  This data is derived from the Human Activity Recognition Using Smartphones Data Set. More information is available here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The original data set is available here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and must be downloaded and unzipped into your R subdirectory before running the run_analysis.R script.

####Data Background
#####This data is from experiments conducted with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Data was captured using its embedded accelerometer and gyroscope. The following data was captured:3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 

####Objective
####The original data was provided in various separate files that was not a tidy data set. I have taken this data, and as the instructions of this class project demanded, created a tidy data using R. The details are in an R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names by removing unnecessary “()”.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#### Detailed Data transformations
##### Step 1: Merges the training and the test sets to create one data set: This step took the various files and merged them into one file.  The various files used: features.txt; activity_labels.txt, subject_train.txt, subject_test.txt, x_train.txt, y_train.txt, x_test.txt, and y_test.txt files.

##### Step 2: Extracts only the measurements on the mean and standard deviation for each measurement: The original datafile had many more measurments than the mean and standard deviations of the X, Y, and Z coordinates (such as min, max, irq, entropy...). This step eliminates these unwanted metrics.  The data in the final tidy dataset provided is the mean sensor reading per subject, per activity.
#####Step 3: Uses descriptive activity names to name the activities in the data set:
#####I not only created a variable with the activity codes, but a variable with descriptive activity labels. The activity codes used follow:
#####  1 - WALKING
#####  2 - WALKING_UPSTAIRS
#####  3 - WALKING_DOWNSTAIRS
#####  4 - SITTING
#####  5 - STANDING
#####  6 - LAYING
##### Step 4: Appropriately labels the data set with descriptive variable names by removing unnecessary “()”.

#####Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

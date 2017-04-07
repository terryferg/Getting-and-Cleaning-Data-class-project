--- 
title: "Read.Me file for Getting and Cleaning Data Repository"
author: "Terry Ferg"
date: "4/7/2017"

##### This is the read.me file describing the tidy dataset analysis file
##### cellphone.accelerometer.tidy.data.csv, for the Coursera Getting and Cleaning 
##### Data course project.  There is also a Code.Book.md in the project repository
##### to review more detail.

The run_analysis.R script reads data from the "Human Activity Recognition Using Smartphones Dataset Version" and produces a tidy dataset which may be used for further analysis.

The run_analysis.R script reads data from the Human Activity Recognition Using Smartphones Data Set. More information is available here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The original data set is available here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip This needs to be downloaded, and unzipped in the same directory R is pointed. 

Note: the original data is divided into a test dataset and a training dataset that needs to be combined for this course project. Also subject sensor data and codes of various subject activies 
were all provided in separate, very non-tidy data files. After running the run_analysis.R script
on the data files one has a nice tidy data file for further analysis!

The run_analysis.R file will: 
* Download and unzip the file located: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
  this creates the folder "UCI HAR Dataset" which you should set as your default R directory for this script.
* Download the various files needed including: 
  * subject ids for both training and test sets: "subject_test.txt" / "subject_train.txt
  * variable names - "features.txt"
  * subject activity labels ("walking", "sitting"...) "activity_labels.txt"
  * activity code for each sensor reading "y_test.txt"/ y_train.txt" (corresponds to activity label       above)
  * test and control subject's sensor reading, per activity ("x_train.txt"/"x_test.txt")
  
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement (per class     project instructions).
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names by removing unnecessary “()”.
* From the above steps, creates a second, independent tidy data set with the average of each variable   for each activity and each subject.
* Saves the new tidy datafile into a table file named: "cellphone.accelerometer.tidy.data.txt".




################################################################################
## Coursera Getting and Cleaning Data Course Project
## Terry Ferg
## April, 2017
## run_analysis.R
################################################################################ 
## This R script, called run_analysis.R, does the following with the cell phone
## accelerometer data:
##
##  1) Merges the training and the test sets to create one data set.
##  2) Extracts only the measurements on the mean and standard deviation
##  for each measurements.
##  3) Uses descriptive activity names to name the activities in the data set
##  4) Appropriately labels the data set with descriptive variable names.
##  5) From the data set in step 4, creates a second, independent tidy data set 
##  with the average of each variable for each activity and each subject.
################################################################################  

############ Step 1: Creating a directory to save the data files #######################
getwd()
rm(list=ls()) # clean the workspace and start fresh

setwd("~/Documents/R and Stat Notes/Getting, Cleanning Data") # this is our base
getwd()
list.files()
if(!file.exists("./project")) {dir.create("./project")}#creates directory
setwd("~/Documents/R and Stat Notes/Getting, Cleanning Data/project")

      
################################################################################
################## step 2: download the zip file into our new project directory#
################################################################################
################## note The file can be manually downloaded an unzipped!! ######
### view contents there should be folder named "UCI HAR Dataset" with several ##
### with several files and two subdirectories "test" and "train"   ############
###  read the README.txt file. Read Features_info.txt ##########################
##
## Download the datafile from the following location:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## unzip the file creating a folder "UCI HAR Dataset" 
list.files() # "UCI HAR Dataset" Should now exist
################################################################################
################## step 3: read in the various files to be merged  #############
##  reading in the features.txt file, which is the variable names for the
## data files.

setwd("~/Documents/R and Stat Notes/Getting, Cleanning Data/project/UCI HAR Dataset")
getwd()

list.files()
variable.labels <- read.table("features.txt", header = FALSE)
names(variable.labels) <- c("variable number", "feature")
head(variable.labels) # see if it read in correctly
tail(variable.labels)
dim(variable.labels)[1]# number of rows should be 561
######  4: read in the activity_labels.txt file, which shows the codes for 
######  the 6 activity labels:
## 
##  1 WALKING
##  2 WALKING_UPSTAIRS
##  3 WALKING_DOWNSTAIRS
##  4 SITTING
##  5 STANDING
##  6 LAYING

activity_labels.df <- read.table("activity_labels.txt", header = FALSE)
######  5: reading in the test data set files
file <- file.path("~/Documents/R and Stat Notes/Getting, Cleanning Data/project/UCI HAR Dataset/test/")
                 # "/UCI HAR Dataset/test/")
setwd(file)
getwd()
list.files()
subject_test.df <- read.table("subject_test.txt", header = FALSE)# subjects ids for test group 
x_test.txt.df <- read.table("X_test.txt", header = FALSE)# Test data w/561 vars
y_test.txt.df <- read.table("y_test.txt", header = FALSE)# Test labels

######  6: reading in the train data set files  ###############################
file <- file.path("~/Documents/R and Stat Notes//Getting, Cleanning Data/project",
                  "/UCI HAR Dataset/train/")
setwd(file)
getwd()
list.files()
subject_train.df <- read.table("subject_train.txt", header = FALSE)# subjectsids 
x_train.txt.df <- read.table("X_train.txt", header = FALSE)# Test data w/561vars
y_train.txt.df <- read.table("y_train.txt", header = FALSE)# Test labels

################################################################################
#################  Step 7: merging data file ###################################
## now we need to add the subject.ids to the data files and add the feature 
## labels to the data files too
##
## Step 7a: adding feature labels to test and training data sets
str(variable.labels$feature)

names(x_test.txt.df) <- (variable.labels[,2]) # adding variable names
names(x_train.txt.df) <- (variable.labels[,2])# adding variable names

x_test.txt.df <- cbind(subject_test.df, x_test.txt.df) # now we have 
names(x_test.txt.df)[1] <-"subject.id" # now we have the subject id with data
x_test.txt.df <- cbind(y_test.txt.df, x_test.txt.df) ## activity labels
names(x_test.txt.df)[1] <- "activity.code" # aka test label(walking, laying...)

######  the 6 activity labels:
## 
##  1 WALKING
##  2 WALKING_UPSTAIRS
##  3 WALKING_DOWNSTAIRS
##  4 SITTING
##  5 STANDING
##  6 LAYING

x_test.txt.df$activity.code.label <- ifelse(x_test.txt.df$activity.code=="1",
            "Walking", 
            ifelse(x_test.txt.df$activity.code=="2", "Walking_Upstairs", 
            ifelse(x_test.txt.df$activity.code=="3", "Walking_Downstairs", 
            ifelse(x_test.txt.df$activity.code=="4", "Sitting",
            ifelse(x_test.txt.df$activity.code=="5", "Standing", "Laying"
                   )))))
x_test.txt.df[,c(1,564)]
x_test.txt.df <- x_test.txt.df[,c(1, 564, 2:563)] # putting the code and its 
                                                  # label next to each other
################################################################################
### now adding the variables to the train data set similar to the test set above
################################################################################
x_train.txt.df <- cbind(subject_train.df, x_train.txt.df) # now we have s
names(x_train.txt.df)[1] <-"subject.id" # now we have the subject id with data
x_train.txt.df <- cbind(y_train.txt.df, x_train.txt.df) ## activity labels
names(x_train.txt.df)[1] <- "activity.code" # aka test label(walking, laying...)

######  the 6 activity labels:
## 
##  1 WALKING
##  2 WALKING_UPSTAIRS
##  3 WALKING_DOWNSTAIRS
##  4 SITTING
##  5 STANDING
##  6 LAYING

x_train.txt.df$activity.code.label <- ifelse(x_train.txt.df$activity.code=="1",
              "Walking", 
             ifelse(x_train.txt.df$activity.code=="2", "Walking_Upstairs", 
             ifelse(x_train.txt.df$activity.code=="3", "Walking_Downstairs", 
             ifelse(x_train.txt.df$activity.code=="4", "Sitting",
             ifelse(x_train.txt.df$activity.code=="5", "Standing", "Laying"
             )))))
x_train.txt.df[,c(1,564)]
x_train.txt.df <- x_train.txt.df[,c(1, 564, 2:563)] # putting the code and its 

names(x_train.txt.df)
all.equal.character(names(x_train.txt.df), names(x_test.txt.df)) #makes sure all
                                                # variable names are equal
                    
################################################################################
############################# Merging the files together now ###################
################################################################################
x.all.df<-rbind(x_test.txt.df, x_train.txt.df)## adds the test file to the
                                                    # training file
head(x.all.df)[c(1:5, 564)]
tail(x.all.df)[c(1:5, 564)]
#install.packages(c("psych", "plyr", "dplyr")) ## if not previously installed
library(psych) # for describe function
library(plyr)
library(dplyr) # for summarize function
describe(x.all.df)
names(x.all.df)[c(1:5, 564)]

#### selecting variables we want to keep in the tidy dataset
### these variables are only "mean|std" variables per instructions

col_nums1 <- c(1:3) # we want to keep the first 3 variables
col_nums2 =grep("mean|std",names(x.all.df)) #columns with "mean|std" in name
col_nums_wanted <- c(col_nums1,col_nums2)
col_nums.numeric <- as.numeric(col_nums_wanted)

all.reduced.variables.df <- x.all.df[,col_nums.numeric]
# making the activity code variables and subject ids factors
str(all.reduced.variables.df) 
for (i in 1:3) {
  all.reduced.variables.df[,i] <- as.factor(all.reduced.variables.df[,i])
}
str(all.reduced.variables.df)## it worked
#### cleaning up workspace  ###################################################
rm(x.all.df)
rm(x_test.txt.df)
rm(y_test.txt.df)
rm(x_train.txt.df)
rm(activity_labels.df)
rm(variable.labels)
rm(subject_test.df)
rm(subject_train.df)
rm(col_nums.numeric)
rm(col_nums_wanted)
rm(file)
rm(fileURL)
rm(y_train.txt.df)

### so all.reduced.variables.df is the datafile of interest now.
###############################################################################
# splitting data file by wanted variables

# checking for missing values
sum(is.na(all.reduced.variables.df)) # no missing values, no problem

group.columns <- c("activity.code", "activity.code.label", "subject.id")
data.columns <- names(all.reduced.variables.df[4:82])
all.grouped.df <- ddply(all.reduced.variables.df, group.columns, 
                        function(x) colMeans(x[data.columns]))

setwd("~/Documents/R and Stat Notes/Getting, Cleanning Data/project/UCI HAR Dataset")
getwd()

write.csv(all.grouped.df, file= "cellphone.accelerometer.tidy.data.csv")

                                            
## Note: to read in this completed tidy dataset, set the working directory to location 
## of the file and do the following:
cellphone.accelerometer.tidy.df <- read.csv(file = "cellphone.accelerometer.tidy.data.csv")







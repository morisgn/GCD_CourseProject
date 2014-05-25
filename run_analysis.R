# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive activity names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


# Download and unzip the file

fileURL <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"
zipfile  <- "smartphones.zip"

download.file(fileURL, zipfile) # This may take few minutes (59.7 Mb) - 4 minutes fo me
unzip (zipfile) # The unzip creates a folder called UCI HAR Dataset containing all files and subfolders

download.date <- date()
# Links the class labels with their activity name. 
activity.labels <-  read.table("UCI HAR Dataset//activity_labels.txt", col.names=c("label.id", "activity"), 
                               fill=FALSE, strip.white=TRUE)
##################################################
# Get the Training dataset
##################################################

# Read the Training dataset 
subject.train <-  read.table("UCI HAR Dataset//train//subject_train.txt", fill=FALSE, strip.white=TRUE, col.names=c("subject"))
x.train <-  read.table("UCI HAR Dataset//train//X_train.txt", fill=FALSE, strip.white=TRUE)
y.train <-  read.table("UCI HAR Dataset//train//y_train.txt", fill=FALSE, strip.white=TRUE, col.names=c("label.id"))

# Create a dataframe for the training dataset 
set.train <- data.frame (y.train, subject.train ,  x.train)

# Merge the training dataset with  the activitity dataset for descriptive activity names to name the activities
merged.set.train <- merge(x= activity.labels ,y= set.train ,  by.X =intersect (names(x) , names(y)), all=FALSE)
# Create a vector for the training dataset 
type.train <- rep ("Training",nrow(merged.set.train))
# Add the traning type variable to the training databaset 
merged.set.train <-  cbind (type.train, merged.set.train) # Add a new column to specify the type of data set
merged.set.train <- merged.set.train [, -2]  # Remove the label.id column

# Swap the training dataset colomn to have the subject, activity and type for the first three colomn of the set
merged.set.train <- merged.set.train[ , c(3, 2,1, 4:ncol(merged.set.train)) ]

##################################################
# Get the Test dataset
##################################################

# Read the Test dataset 
subject.test <-  read.table("UCI HAR Dataset//test//subject_test.txt", fill=FALSE, strip.white=TRUE, col.names=c("subject"))
x.test <-  read.table("UCI HAR Dataset//test//X_test.txt", fill=FALSE, strip.white=TRUE)
y.test <-  read.table("UCI HAR Dataset//test//y_test.txt", fill=FALSE, strip.white=TRUE, col.names=c("label.id"))

# Create a dataframe for the test dataset 
set.test <- data.frame (y.test, subject.test ,  x.test)

# Merge the test dataset with  the activitity dataset for descriptive activity names to name the activities
merged.set.test <- merge(x= activity.labels ,y= set.test ,  by.X =intersect (names(x) , names(y)), all=FALSE)
# Create a vector for the test dataset 
type.test <- rep ("Test",nrow(merged.set.test))
# Add the test type variable to the test databaset 
merged.set.test <-  cbind (type.test, merged.set.test) # Add a new column to specify the type of data set
merged.set.test <- merged.set.test [, -2]

# Swap the test dataset colomn to have the subject, activity and type for the first three colomn of the set
merged.set.test <- merged.set.test[ , c(3, 2,1, 4:ncol(merged.set.test)) ]

##################################################
# Get the dataset features 
##################################################

# Read the features 
features <-  read.table("UCI HAR Dataset//features.txt", fill=FALSE, strip.white=TRUE, col.names=c("id", "features.name"))

features.names <- as.character (features[,2]) # The features names is in the second column

# Create the column names for the dataset (training and test) 
data.colNames <- c ("subject", "activity", "set.type", features.names)

names(merged.set.train) <- data.colNames
names(merged.set.test) <- data.colNames

#  Create the processed data
processed.data<- rbind(merged.set.train,merged.set.test)
# Write the processed data in a text file
write.table(processed.data, file = "processed_data.txt", sep= ",", row.names=FALSE)


##################################################
# Extracts only the measurements on the mean 
# and standard deviation for each measurement. 
##################################################

# variable measurements on the mean and standard deviation  
mean.stdCol <- grepl("mean()", features.names, ignore.case=FALSE, fixed= TRUE) | (grepl("std()", features.names) )
mean.stdCol <- features.names [mean.stdCol]

# Create the header for the tidy data 
tidyData.colNames <- names (processed.data)
new.colNames <- c (tidyData.colNames[1:3], mean.stdCol)

# Tidy dataset with mean and standard deviation variable 
tidy.data <- processed.data[,new.colNames]
tidyData.colNames <- names (tidy.data)

##################################################
# # Appropriately labels the data set with descriptive activity names.
##################################################

tidyData.colNames <- gsub("-mean()","Mean",tidyData.colNames,fixed= TRUE)
tidyData.colNames <- gsub("-std()","Standarddeviation",tidyData.colNames,fixed= TRUE)
tidyData.colNames <- gsub("Acc","Accelerometer",tidyData.colNames,fixed= TRUE)
tidyData.colNames <- gsub("Gyro","Gyroscope",tidyData.colNames,fixed= TRUE)
tidyData.colNames <- gsub("Mag","Magnitude",tidyData.colNames,fixed= TRUE)
tidyData.colNames <- gsub("tBody","TimeBody",tidyData.colNames,fixed= TRUE)
tidyData.colNames <- gsub("tGravity","TimeGravity",tidyData.colNames,fixed= TRUE)
tidyData.colNames <- gsub("fBody","FrequencyBody",tidyData.colNames,fixed= TRUE)
tidyData.colNames <- gsub("-X","X",tidyData.colNames,fixed= TRUE)
tidyData.colNames <- gsub("-Y","Y",tidyData.colNames,fixed= TRUE)
tidyData.colNames <- gsub("-Z","Z",tidyData.colNames,fixed= TRUE)

names (tidy.data) <- tidyData.colNames

# load plyr and cumpute the average of each variable for each activity and each subject
library("plyr")
tidy.data <- ddply(tidy.data, .(subject =tidy.data$subject, activity= tidy.data$activity), numcolwise(mean))


# Write the second tidy data in a text file
write.table(tidy.data, file = "tidy_data.txt", sep= ",", row.names=FALSE)

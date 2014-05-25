This file contains information about the variables, the summary choices I made and the experimental study design used for this project.   

Code book
=========
The folowwing section describes each variable used in the data set and its units. 

Raw data are transformed to processed data that are used to produce the tidy data. A complete descrption of the data set and its variables can be found here : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and under this link : http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip. Below is the list of all varibles used in the tidy data. 


 [1] "subject"                                                     
 [2] "activity"                                                    
 [3] "TimeBodyAccelerometerMeanX"                                  
 [4] "TimeBodyAccelerometerMeanY"                                  
 [5] "TimeBodyAccelerometerMeanZ"                                  
 [6] "TimeBodyAccelerometerStandarddeviationX"                     
 [7] "TimeBodyAccelerometerStandarddeviationY"                     
 [8] "TimeBodyAccelerometerStandarddeviationZ"                     
 [9] "TimeGravityAccelerometerMeanX"                               
[10] "TimeGravityAccelerometerMeanY"                               
[11] "TimeGravityAccelerometerMeanZ"                               
[12] "TimeGravityAccelerometerStandarddeviationX"                  
[13] "TimeGravityAccelerometerStandarddeviationY"                  
[14] "TimeGravityAccelerometerStandarddeviationZ"                  
[15] "TimeBodyAccelerometerJerkMeanX"                              
[16] "TimeBodyAccelerometerJerkMeanY"                              
[17] "TimeBodyAccelerometerJerkMeanZ"                              
[18] "TimeBodyAccelerometerJerkStandarddeviationX"                 
[19] "TimeBodyAccelerometerJerkStandarddeviationY"                 
[20] "TimeBodyAccelerometerJerkStandarddeviationZ"                 
[21] "TimeBodyGyroscopeMeanX"                                      
[22] "TimeBodyGyroscopeMeanY"                                      
[23] "TimeBodyGyroscopeMeanZ"                                      
[24] "TimeBodyGyroscopeStandarddeviationX"                         
[25] "TimeBodyGyroscopeStandarddeviationY"                         
[26] "TimeBodyGyroscopeStandarddeviationZ"                         
[27] "TimeBodyGyroscopeJerkMeanX"                                  
[28] "TimeBodyGyroscopeJerkMeanY"                                  
[29] "TimeBodyGyroscopeJerkMeanZ"                                  
[30] "TimeBodyGyroscopeJerkStandarddeviationX"                     
[31] "TimeBodyGyroscopeJerkStandarddeviationY"                     
[32] "TimeBodyGyroscopeJerkStandarddeviationZ"                     
[33] "TimeBodyAccelerometerMagnitudeMean"                          
[34] "TimeBodyAccelerometerMagnitudeStandarddeviation"             
[35] "TimeGravityAccelerometerMagnitudeMean"                       
[36] "TimeGravityAccelerometerMagnitudeStandarddeviation"          
[37] "TimeBodyAccelerometerJerkMagnitudeMean"                      
[38] "TimeBodyAccelerometerJerkMagnitudeStandarddeviation"         
[39] "TimeBodyGyroscopeMagnitudeMean"                              
[40] "TimeBodyGyroscopeMagnitudeStandarddeviation"                 
[41] "TimeBodyGyroscopeJerkMagnitudeMean"                          
[42] "TimeBodyGyroscopeJerkMagnitudeStandarddeviation"             
[43] "FrequencyBodyAccelerometerMeanX"                             
[44] "FrequencyBodyAccelerometerMeanY"                             
[45] "FrequencyBodyAccelerometerMeanZ"                             
[46] "FrequencyBodyAccelerometerStandarddeviationX"                
[47] "FrequencyBodyAccelerometerStandarddeviationY"                
[48] "FrequencyBodyAccelerometerStandarddeviationZ"                
[49] "FrequencyBodyAccelerometerJerkMeanX"                         
[50] "FrequencyBodyAccelerometerJerkMeanY"                         
[51] "FrequencyBodyAccelerometerJerkMeanZ"                         
[52] "FrequencyBodyAccelerometerJerkStandarddeviationX"            
[53] "FrequencyBodyAccelerometerJerkStandarddeviationY"            
[54] "FrequencyBodyAccelerometerJerkStandarddeviationZ"            
[55] "FrequencyBodyGyroscopeMeanX"                                 
[56] "FrequencyBodyGyroscopeMeanY"                                 
[57] "FrequencyBodyGyroscopeMeanZ"                                 
[58] "FrequencyBodyGyroscopeStandarddeviationX"                    
[59] "FrequencyBodyGyroscopeStandarddeviationY"                    
[60] "FrequencyBodyGyroscopeStandarddeviationZ"                    
[61] "FrequencyBodyAccelerometerMagnitudeMean"                     
[62] "FrequencyBodyAccelerometerMagnitudeStandarddeviation"        
[63] "FrequencyBodyBodyAccelerometerJerkMagnitudeMean"             
[64] "FrequencyBodyBodyAccelerometerJerkMagnitudeStandarddeviation"
[65] "FrequencyBodyBodyGyroscopeMagnitudeMean"                     
[66] "FrequencyBodyBodyGyroscopeMagnitudeStandarddeviation"        
[67] "FrequencyBodyBodyGyroscopeJerkMagnitudeMean"                 
[68] "FrequencyBodyBodyGyroscopeJerkMagnitudeStandarddeviation"

Study design
============

This section explains how the data was collected and transformed int tidy data. 

### Download the raw data 

The raw data was downloaded from this link http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip and unizipped. 

The dowloaded folder contains the following files: 
- 'features_info.txt': Shows information about the variables used on the feature vector.  
- 'features.txt': List of all features.  
- 'activity_labels.txt': Links the class labels with their activity name.  
- 'train/X_train.txt': Training set.  
- 'train/y_train.txt': Training labels.  
- 'test/X_test.txt': Test set.  
- 'test/y_test.txt': Test labels.  

__dowloaded.date__ : "Sun May 18 06:30:08 2014"

### Read the training and test data 

* Read the training dataset.
* Read the test dataset. 
* Create a vector "type" to specify the set is a training or test data 
* Add the type vector in both training and test dataset using cbind
* Read the activity dataset 
* Merge the activity dataset and the training dataset using merge
* Merge the activity dataset and the test dataset using merge
* Read the features dataset to get the header for both the test and training data
* Use rbind to combine training and test data
* Write the combined data set in a file

  
### Extracts only the measurements on the mean and standard deviation for each measurement. 
* Use grepl to extract from the processed data, variables that contain only mean() or std()
* Create the header for the tidy data 
* Appropriately labels the data set with descriptive activity names by using gsub

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

* Use plyr library 
* cumpute the average of each variable for each activity and each subject by using ddply
* Columns are averaged grouping by "Activity" and "subject"
* Tidy set is written to a file.

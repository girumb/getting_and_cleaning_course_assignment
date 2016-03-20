# read the test and training data to perpare for the merge 

    x_train <- read.table('.\\UCI_HAR_Dataset\\train\\X_train.txt') #reads the main training dataset
    
    y_train<- read.table('.\\UCI_HAR_Dataset\\train\\y_train.txt') #reads the activities for the training dataset as coded
    
    x_test <- read.table('.\\UCI_HAR_Dataset\\test\\X_test.txt') # reads the main test dataset
    
    y_test<- read.table('.\\UCI_HAR_Dataset\\test\\y_test.txt') # reads the activities for the test dataset as coded
    
    activity_label <- read.table('.\\UCI_HAR_Dataset\\activity_labels.txt') #reads the activity label
    
    subject_train<- read.table('.\\UCI_HAR_Dataset\\train\\subject_train.txt')
    
    subject_test <- read.table('.\\UCI_HAR_Dataset\\test\\subject_test.txt')
    
    y_train <- merge(y_train,activity_label,by="V1") # merge the training activity codes with the activity to include activity names 
    
    y_test <- merge(y_test,activity_label,by="V1")
    
    names(y_train) <- c('ActivityCode','ActivityName') #Give proper description for the activitycodes and names
    
    names(y_test) <- c('ActivityCode','ActivityName') #Give proper description for the activitycodes and names
      
    x_train <- cbind(x_train,y_train) #Agument the x_train with the activity names
    
    x_test <-  cbind(x_test,y_test) #Agument the x_test with the activity names
    
    x_train <- cbind(x_train,subject_train) #Agument the x_train with the subject data
    
    x_test <-  cbind(x_test,subject_test) #Agument the x_test with the subject data

# 1. Merges the training and the test sets to create one data set.
# This should be a row merge or Union of the two datasets

    x_merged <- rbind(x_train,x_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# mean_sd_columns vector identifies all mean and sd data
    mean_sd_columns <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,
                     166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,
                     425,426,427,428,429,503,504,516,517,529,530,542,543,563,564)

    x_mean_sd_extracted <- x_merged[,mean_sd_columns]

# 3. Uses descriptive activity names to name the activities in the data set [this is done through a previous step in line 21 ]

# 4. Appropriately labels the data set with descriptive variable names.

    tidy_header <- c('MeanTimeBodyAcc_Xaxis','MeanTimeBodyAcc_Yaxis','MeanTimeBodyAcc_Zaxis','StdTimeBodyAcc_Xaxis','StdTimeBodyAcc_Yaxis','StdTimeBodyAcc_Zaxis',
           'MeanTimeGravityAcc_Xaxis','MeanTimeGravityAcc_Yaxis','MeanTimeGravityAcc_Zaxis','StdTimeGravityAcc_Xaxis','StdTimeGravityAcc_Yaxis','StdTimeGravityAcc_Zaxis','MeanTimeBodyAccJerk_Xaxis','MeanTimeBodyAccJerk_Yaxis','MeanTimeBodyAccJerk_Zaxis','StdTimeBodyAccJerk_Xaxis',
           'StdTimeBodyAccJerk_Yaxis','StdTimeBodyAccJerk_Zaxis','MeanTimeBodyGyro_Xaxis','MeanTimeBodyGyro_Yaxis','MeanTimeBodyGyro_Zaxis',
           'StdTimeBodyGyro_Xaxis','StdTimeBodyGyro_Yaxis','StdTimeBodyGyro_Zaxis','MeanTimeBodyGyroJerk_Xaxis','MeanTimeBodyGyroJerk_Yaxis',
           'MeanTimeBodyGyroJerk_Zaxis','StdTimeBodyGyroJerk_Xaxis','StdTimeBodyGyroJerk_Yaxis','StdTimeBodyGyroJerk_Zaxis','MeanTimeBodyAccMag',
           'StdTimeBodyAccMag','MeanTimeGravityAccMag','StdTimeGravityAccMag','MeanTimeBodyAccJerkMag','StdTimeBodyAccJerkMag','MeanTimeBodyGyroMag',
           'StdTimeBodyGyroMag','MeanTimeBodyGyroJerkMag','StdTimeBodyGyroJerkMag','MeanFrequencyBodyAcc_Xaxis','MeanFrequencyBodyAcc_Yaxis',
           'MeanFrequencyBodyAcc_Zaxis','StdFrequencyBodyAcc_Xaxis','StdFrequencyBodyAcc_Yaxis','StdFrequencyBodyAcc_Zaxis','MeanFrequencyBodyAccJerk_Xaxis','MeanFrequencyBodyAccJerk_Yaxis','MeanFrequencyBodyAccJerk_Zaxis','StdFrequencyBodyAccJerk_Xaxis','StdFrequencyBodyAccJerk_Yaxis',
           'StdFrequencyBodyAccJerk_Zaxis','MeanFrequencyBodyGyro_Xaxis','MeanFrequencyBodyGyro_Yaxis','MeanFrequencyBodyGyro_Zaxis',
           'StdFrequencyBodyGyro_Xaxis','StdFrequencyBodyGyro_Yaxis','StdFrequencyBodyGyro_Zaxis','MeanFrequencyBodyAccMag',
           'StdFrequencyBodyAccMag','MeanFrequencyBodyBodyAccJerkMag','StdFrequencyBodyBodyAccJerkMag','MeanFrequencyBodyBodyGyroMag',
           'StdFrequencyBodyBodyGyroMag','MeanFrequencyBodyBodyGyroJerkMag','StdFrequencyBodyBodyGyroJerkMag','ActivityName','SubjectId')

names(x_mean_sd_extracted)<- tidy_header

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

    agg_data<-aggregate(x_mean_sd_extracted[1:66] ,by=list(ActivityName=x_mean_sd_extracted$ActivityName,SubjectId=x_mean_sd_extracted$SubjectId), FUN=mean)
    
    #write the aggregated data to file
    write.table(agg_data,'.\\FinalTidyData.txt',row.name=FALSE)
    



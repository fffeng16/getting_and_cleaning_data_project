# Code Book

This code book summarises the data, the variables, and the work performed to produce the data in `tidy.txt`

### Data
* Raw data - The raw data is collected from the accelerometers from the Samsung Galaxy S smartphone. The data is generated from experiments on 30 subjects who performed six different activiites (see "activity" in Variables below). 

* Processed data - the processed data summarises the mean and standard deviations from the various measurements included in the raw data. 

### Variables
There are 68 variables in total in the processed data set. 

* subject - the identifier of the 30 subjects. It is of int type, and ranges from 1 to 30. 

* activity - the identifier of the 6 activities. It is of chr type with values {WALKING, WALKING_UPSTAIRS, WALKING-DOWNSTAIRS, SITTING, STANDING, and LAYING}.

* measurements - the rest of the variables are the measurements on the mean and standard deviations for different measurements. Variables with t prefix are measured in the time domain and variables with f prefix are in the frequency domain. 

   + Each of the following variables is measured in X, Y and Z direction independently (and each with mean and std statistics). Hence there are 8 * 6 = 48 variables in total in this group. {`tBodyAcc`, `tGravityAcc`, `tBodyAccJerk`, `tBodyGyro`, `tBodyGyroJerk`, `fBodyAcc`, `fBodyAccJerk`, `fBodyGyro`}

   + There are 18 variables in the next group (each with mean and std statistics) {`tBodyAccMag`, `tGravityAccMag`, `tBodyAccJerkMag`, `tBodyGyroMag`, `tBodyGyroJerkMag`, `fBodyAccMag`, `fBodyBodyAccJerkMag`, `fBodyBodyGyroMag`, `fBodyBodyGyroJerkMag`}
   
### Data Processing
1. Download the raw dataset if it does not already exist in the working directory
2. Load both the training and test data sets.
3. Merge the training and the test data sets.
4. Load the features data to select only the measurements on the mean and standard deviation for each measurement. 
5. Load the activity data to use descriptive activity names to name the activities (instead of label) in the data set
6. Appropriately label the data set with descriptive variable names.
7. Create a tidy dataset that consists of the average value of each variable for each subject and activity pair.
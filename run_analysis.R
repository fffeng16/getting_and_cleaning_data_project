library(dplyr)


# 1. download the raw dataset if it does not already exist in the working directory
filename <- "getdata-projectfiles-UCI HAR Dataset.zip"
if(!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}
if(!file.exists("UCI HAR Dataset")){
  unzip(filename)
}


# 2. loads both the training and test datasets,
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names="subject")
train_features <- read.table("UCI HAR Dataset/train/X_train.txt")
train_activity <- read.table("UCI HAR Dataset/train/y_train.txt", col.names="activity_label")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names="subject")
test_features <- read.table("UCI HAR Dataset/test/X_test.txt")
test_activity <- read.table("UCI HAR Dataset/test/y_test.txt", col.names="activity_label")


# 3. merge the training and the test data sets.
train <- cbind(train_subject, train_activity, train_features)
test <- cbind(test_subject, test_activity, test_features)
data <- rbind(train, test)


# 4. Load the features data and use that to extract only the measurements 
#    on the mean and standard deviation for each measurement.
features <- read.table("UCI HAR Dataset/features.txt")
featuresUsed <- grep("mean\\(\\)|std\\(\\)", features$V2) + 2 #first 2 cols are subject and activity res. 
dataUsed <- select(data, subject, activity_label, featuresUsed)


# 5. Load the activity data to use descriptive activity names 
#    to name the activities (instead of label) in the data set
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE, 
                              col.names=c("label", "activity"))
dataUsed <- mutate(dataUsed, activity = activity_labels[match(activity_label, activity_labels$label), 2])
dataUsed <- select(dataUsed, -activity_label)
dataUsed <- dataUsed[ , c(1,68,2:67)]


# 6. Appropriately label the data set with descriptive variable names.
newColNames <- as.character(features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)])
names(dataUsed)[3:68] <- newColNames


# 7. Create a tidy dataset that consists of the average value of each variable 
#    for each subject and activity pair.
dataTidy <- group_by(dataUsed, subject, activity) %>%
            summarise_each(funs(mean))

write.table(dataTidy, "tidy.txt", row.names = FALSE, quote = FALSE)
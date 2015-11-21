library(data.table)
library(dplyr)

# 1. Merges the training and the test sets to create one data set.

t1_xtrain <- read.table("./data/UCI_HAR_Dataset/train/X_train.txt", header = FALSE)
t2_xtest <- read.table("./data/UCI_HAR_Dataset/test/X_test.txt", header = FALSE)
X_features <- rbind(t1_xtrain, t2_xtest)

t1_strain <- read.table("./data/UCI_HAR_Dataset/train/subject_train.txt", header = FALSE)
t2_stest <- read.table("./data/UCI_HAR_Dataset/test/subject_test.txt", header = FALSE)
S_subject <- rbind(t1_strain, t2_stest)

t1_ytrain <- read.table("./data/UCI_HAR_Dataset/train/y_train.txt", header = FALSE)
t2_ytest <- read.table("./data/UCI_HAR_Dataset/test/y_test.txt", header = FALSE)
Y_activity <- rbind(t1_ytrain, t2_ytest)

features <-  read.table("./data/UCI_HAR_Dataset/features.txt")
activity_lables  <- read.table("./data/UCI_HAR_Dataset/activity_labels.txt", header = FALSE)


# Name of the columns
colnames(X_features) <- t(features[2])
colnames(Y_activity) <- "Activity"
colnames(S_subject)  <-  "Subject"

# build a dataset

DataSet <- cbind(X_features, Y_activity, S_subject)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

StdColmean  <- grep(".*Mean.*|.*Std.*",x = names(DataSet), ignore.case=TRUE)
filter_of_redCols <- c(StdColmean, 562:563)
x_Data <- DataSet[, filter_of_redCols]


# 3.Uses descriptive activity names to name the activities in the data set

x_Data$Activity <- as.character(x_Data$Activity)
for(i in 1:6) {
  x_Data$Activity[x_Data$Activity == i] <- as.character(activity_lables[,2])
}
x_Data$Activity <- as.factor(x_Data$Activity)

# 4. Appropriately labels the data set with descriptive variable names.

names(x_Data)<-gsub("Acc", "Accelerometer", names(x_Data))
names(x_Data)<-gsub("Gyro", "Gyroscope", names(x_Data))
names(x_Data)<-gsub("BodyBody", "Body", names(x_Data))
names(x_Data)<-gsub("Mag", "Magnitude", names(x_Data))
names(x_Data)<-gsub("^t", "Time", names(x_Data))
names(x_Data)<-gsub("^f", "Frequency", names(x_Data))
names(x_Data)<-gsub("tBody", "Time_Body", names(x_Data))
names(x_Data)<-gsub("-mean()", "Mean", names(x_Data), ignore.case = TRUE)
names(x_Data)<-gsub("-std()", "STD", names(x_Data), ignore.case = TRUE)
names(x_Data)<-gsub("-freq()", "Frequency", names(x_Data), ignore.case = TRUE)
names(x_Data)<-gsub("angle", "Angle", names(x_Data))
names(x_Data)<-gsub("gravity", "Gravity", names(x_Data))

# 5.From the data set in step 4, creates a second, independent tidy data set with 
#   the average of each variable for each activity and each subject.

x_Data$Subject <- as.factor(x_Data$Subject)
x_Data <- data.table(x_Data)

tidy_d <- aggregate(. ~Subject+Activity,x_Data,mean) 
tidy_d <- tidy_d[order(tidy_d$Subject,tidy_d$Activity),]
write.table(x = tidy_d,file = "tidy_data_set.txt",row.names = FALSE)
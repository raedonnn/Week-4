library(dplyr)

filename <- "getdata_projectfiles_UCI HAR Dataset.zip"
if (!file.exists(filename)) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}

if (!file.exists("UCI HAR Dataset")) {
  unzip(filename)
}

##read descriptions and labels
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

##read test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/x_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

##read train data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/x_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

##merging training and test sets
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
Sub <- rbind(subject_train, subject_test)
merged <- cbind(Sub, y, x)

##extracts mean and standard deviation
tidy <- merged %>% select(subject, code, contains("mean"), contains("std"))
tidy$code <- activities[tidy$code, 2]

##name activities, labels data set
names(tidy)[2] = "activity"
names(tidy) <- gsub("Acc", "Accelerometer", names(tidy))
names(tidy) <- gsub("Gyro", "Gyroscope", names(tidy))
names(tidy) <- gsub("BodyBody", "Body", names(tidy))
names(tidy) <- gsub("Mag", "Magnitude", names(tidy))
names(tidy) <- gsub("^t", "Time", names(tidy))
names(tidy) <- gsub("^f", "Frequency", names(tidy))
names(tidy) <- gsub("tBody", "TimeBody", names(tidy))
names(tidy) <- gsub("-mean()", "Mean", names(tidy), ignore.case = TRUE)
names(tidy) <- gsub("-std()", "STD", names(tidy), ignore.case = TRUE)
names(tidy) <- gsub("-freq()", "Frequency", names(tidy), ignore.case = TRUE)
names(tidy) <- gsub("angle", "Angle", names(tidy))
names(tidy) <- gsub("gravity", "Gravity", names(tidy))

##creates independent tidy data set
FinalData <- tidy %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)
The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

Download the dataset: Dataset downloaded and extracted under the folder called UCI HAR Dataset

Assign each data to variables:
1. features <- features.txt
2. activities <- activity_labels.txt
3. subject_test <- test/subject_test.txt
4. x_test <- test/X_test.txt
5. y_test <- test/y_test.txt
6. subject_train <- test/subject_train.txt
7. x_train <- test/X_train.txt
8. y_train <- test/y_train.txt

Merges the training and the test sets to create one data set:
1. x is created by merging x_train and x_test using rbind() function
2. y is created by merging y_train and y_test using rbind() function
3. Sub is created by merging subject_train and subject_test using rbind() function
4. merged is created by merging Sub, y and x using cbind() function

Extracts only the measurements on the mean and standard deviation for each measurement:
tidy is created by subsetting merged, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

Uses descriptive activity names to name the activities in the data set:
Entire numbers in code column of the tidy replaced with corresponding activity taken from second column of the activities variable

Appropriately labels the data set with descriptive variable names:
code column in tidy renamed into activities
1. All Acc in column’s name replaced by Accelerometer
2. All Gyro in column’s name replaced by Gyroscope
3. All BodyBody in column’s name replaced by Body
4. All Mag in column’s name replaced by Magnitude
5. All start with character f in column’s name replaced by Frequency
6. All start with character t in column’s name replaced by Time

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:
FinalData is created by sumarizing tidy taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export FinalData into FinalData.txt file.

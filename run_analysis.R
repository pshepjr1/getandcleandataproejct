## Set working directory to "XXXXXXX"

## Read the X_test, y_test and subject_test files into R from Test and Training
activity_labels <- read.table("activity_labels.txt", quote="\"")
features <- read.table("features.txt", quote="\"")
x_test <- read.table("x_test.txt", quote="\"")
y_test <- read.table("y_test.txt", quote="\"")
x_train <- read.table("x_train.txt", quote="\"")
y_train <- read.table("y_train.txt", quote="\"")
subject_test <- read.table("subject_test.txt", quote="\"")
subject_train <- read.table("subject_train.txt", quote="\"")

## set the column names to match the features
colnames(x_train) <- features[,2]
colnames(x_test) <-  features[,2]
colnames(y_test) <- "Activity_Label"
colnames(y_train) <- "Activity_Label"
colnames(subject_test) <- "Subject"
colnames(subject_train) <- "Subject"

## Item 1 from assignment - Merges the training and the test sets to create one data set.

  ## Merge the test data set (by column)
  test_merged1 <- cbind(y_test, x_test)
  test_merged2 <- cbind(subject_test, test_merged1)

  ## Merge the training data set (by column)
  train_merged1 <- cbind(y_train, x_train)
  train_merged2 <- cbind(subject_train, train_merged1)

  ## Combine the test and training data sets
  ttmerged <- rbind(test_merged2, train_merged2)

## Item2 from assignment - Extracts only the measurements on the mean and standard deviation for each measurement. 
## I took this to mean that I should include any column that had "-mean() or "-std()" in it.
  tt_merge2 <- cbind(ttmerged$Subject, ttmerged$Activity_Label, ttmerged[, grep("-mean()|-std()", colnames(ttmerged))])

## Item 3 from assignement - Uses descriptive activity names to name the activities in the data set

  ## Add coloumn names to have a clear name for any columns not named clearly
  colnames(tt_merge2)[1] <- "Subject"
  colnames(tt_merge2)[2] <- "Activity_Label"

## Item 4 from assignment - Appropriately labels the data set with descriptive variable names. 

  ## convert the Activity_Label to a FActor column that has the name of Activity
  activity_labels2 <- factor(activity_labels$V2)
  tt_merge3 <- cbind(activity_labels2[tt_merge2[,2]], tt_merge2)
  colnames(tt_merge3)[1] <- "Activity"

## Item 5 from assignment - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
## NOTE:  This is ordered by subject and then by the factor created from the activity_labels, NOT the 
## numeric order in the numeric column for activity.  The factor created by using the activity_labels
## data creates the order based on ther order in that factor.

  tt_ordered <- tt_merge3[order(tt_merge3$Subject, tt_merge3$Activity),]

  ## Aggregate by subject and activity for that subject
  aggdata <- aggregate(.~Activity+Subject, FUN=mean, data=tt_ordered)

  write.csv(aggdata, file="./run_analysis_output.txt")

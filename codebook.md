This file represents the codebook for the run_analysis.R file

The run_analysis.R file depends on the following data files to be in the current working directory when it is executed.

Activity_Labels.txt - contiains textual labels for the testing that occurred
Features.txt - contains the labeled features for the device used in the test
subject_test.txt - provides a number to identify the subject in each test
x_test.txt - provides the actual proccesed measurement data for each of the test measurements in Features.txt file
y_test - provides the numeric code for each of the test activities listed in the Activity_Labels
subject_train.txt - provides a number to identify the subject in each train session
x_train.txt - provides the actual proccesed measurement data for each of the train measurements in Features.txt file
y_train - provides the numeric code for each of the train activities listed in the Activity_Labels

Processing

Each file listed above is read into data.frames in R
Labels are added approppriately to provide easier identification of data fields
Data is merged for the test data items (subject_test, y_test and x_test merged by column)
Data is merged for the train data items (subject_train, y_train and x_train merged by column)

The test and train data is then merged by row to produce a single data set.

The merged data set is then used to extract only columns that contain either "-mean()" or "-std()" fields per the instructions.

This resulting data set is them sorted by subject and then tests (using the label for activity).

The resulting data set is the aggregated on subject and activity to produce means for each value in the set.

The final aggregated data set is them written to a .csv file as output.

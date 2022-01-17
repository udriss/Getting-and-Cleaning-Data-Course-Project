# Getting-and-Cleaning-Data-Course-Project
Coursera project for the course 3, week 4.

-----------
Please check the code for further information and precision.


The script make the following steps :

# 1. Merge the training and the test sets to create one data set
Test set :Open training set file and store in data_Xtest
Training set : open test set file and store in data_Xtrain

# 2. Extract only the measurements on the mean and standard deviation for each measurement
Select data with variable wich contain characters "mean"
Select data with variable wich contain characters "std"

# 3. Uses descriptive activity names to name the activities in the data set
Loop to change values

# 4. Appropriately label the data set with descriptive variable names
Formating testing names and then training names
Merge data names with "mean" and "std"

# 5. Second independent tidy data set with the average of each variable for each activity and each subject
summarise data by taking the mean of each variable for each activity and each subject. Contains 6x30 observations of the 88 variables from the final data set.
  + 6 : number of activity
  + 30 : number of vulunteers
  + The mean is obtained by grouping observations in the final data set with the subject IDs then the activity labels.
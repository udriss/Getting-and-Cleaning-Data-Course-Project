library(dplyr)
library(magrittr)






data_features<-read.table(file = "./features.txt",strip.white = T)
activity_labels<-read.table(file = "./activity_labels.txt",strip.white = T)




########### 1. Merge the training and the test sets to create one data set
## Test set
# Open training set file and store in data_Xtest
# data_Xtest<-read.table(file = "./X_test.txt",strip.white = T)
data_Ytest<-read.table(file = "./y_test.txt")
data_subject_test<-read.table(file = "./subject_test.txt")
data_test<-data.frame(data_subject_test,data_Ytest,data_Xtest)
colnames(data_test)<-c("subject_ID","activity_label",data_features[,2])



## Training set
# Open test set file and store in data_Xtrain
# data_Xtrain<-read.table(file = "./X_train.txt",strip.white = T)
data_Ytrain<-read.table(file = "./y_train.txt")
data_subject_train<-read.table(file = "./subject_train.txt")
data_train<-data.frame(data_subject_train,data_Ytrain,data_Xtrain)
colnames(data_train)<-c("subject_ID","activity_label",data_features[,2])





########### 2. Extract only the measurements on the mean and standard deviation for each measurement
# Merge sets
data_merged<-rbind(data_train,data_test)
# Select data with variable wich contain characters "mean"
data_extract<-data_merged[,grepl("[Mm]ean",names(data_merged))]
######################### to erase ########  data_with_mean<-data.frame(data_merged[,1],data_merged[,2],data_extract)
# Select data with variable wich contain characters "std"
data_extract2<-data_merged[,grepl("[Ss][Tt][Dd]",names(data_merged))]

data_selected<-data.frame(data_merged[,1],data_merged[,2],data_extract,data_extract2)
colnames(data_selected)<-c("subject_ID","activity_label",names(data_extract),names(data_extract2))





########### 3. Uses descriptive activity names to name the activities in the data set

# Loop to change values
for (i in 1:length(activity_labels[,2])){
  data_selected$activity_label<-gsub(i,activity_labels[i,2],data_selected$activity_label)
}





########### 4. Appropriately label the data set with descriptive variable names
# Traiting names
names_data_mean<-names(data_extract)
names_data_mean %<>%
  gsub('-','.',.) %>%
  gsub(')','',.) %>%
  gsub('\\(','',.) %>%
  gsub('_','.',.) %>%
  gsub(',','.',.) %>% 
  gsub('^t','time.',.) %>%
  gsub('^f','freq.',.)

# Traiting names
names_data_std_dev<-names(data_extract2)
names_data_std_dev %<>%
  gsub('-','.',.) %>%
  gsub(')','',.) %>%
  gsub('\\(','',.) %>%
  gsub('_','.',.) %>%
  gsub(',','.',.) %>% 
  gsub('^t','time.',.) %>%
  gsub('^f','freq.',.)

# Merge data names with "mean" and "std"
colnames(data_selected)<-c("subject_ID","activity_label",names_data_mean,names_data_std_dev)


########### 5. Second independent tidy data set with the average of each variable for each activity and each subject
data_selected %<>%
  group_by(subject_ID,activity_label)

average_values<-data_selected %>% summarise(across(time.BodyAcc.mean.X:freq.BodyBodyGyroJerkMag.std,mean),.groups = "keep")





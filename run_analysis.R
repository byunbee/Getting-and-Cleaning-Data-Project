# 1. Merge the training and the test sets to create one data set.
#set up working directory
setwd("/Users/sbyunbee/Documents/_Papers/R-Project/Practices/Getting and Cleaning Data/UCI HAR Dataset/")

##read data from files
features <-read.table("./features.txt", header=F)
activity_labels <-read.table("./activity_labels.txt", header=F)

###train
subject_train <-read.table("./train/subject_train.txt", header=F)
x_train <- read.table("./train/X_train.txt", header=F)
y_train <- read.table("./train/y_train.txt", header=F)

###test
subject_test <-read.table("./test/subject_test.txt", header=F)
x_test <- read.table("./test/X_test.txt", header=F)
y_test <- read.table("./test/y_test.txt", header=F)

##column names
colnames(activity_labels) <- c("act_id", "act_type")

###train
colnames(subject_train) <- "subject_id"
colnames(x_train) <- features[,2]
colnames(y_train) <- "act_id"

###test
colnames(subject_test) <- "subject_id"
colnames(x_test) <- features[,2]
colnames(y_test) <- "act_id"

##cbind
###train dataset
train_data <- cbind(y_train, subject_train, x_train)
###test dataset
test_data <- cbind(y_test, subject_test, x_test)

##rbind (final)
uci_data <-rbind(train_data, test_data)


#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
uci_data_measure <- uci_data[, grepl("mean|std|subject_id|act_id", names(uci_data))]


#3. Uses descriptive activity names to name the activities in the data set
uci_data_measure_act <- merge(uci_data_measure, activity_labels, by="act_id", all=T)


#4. Appropriately labels the data set with descriptive variable names. 
tidy.data <- uci_data_measure_act
col.tidy.data <-colnames(tidy.data)
col.tidy.data <- gsub("[Aa]cc", "_Accelerometer_", col.tidy.data) #[Aa] = A or a
col.tidy.data <- gsub("[Gg]yro", "_Gyroscope_", col.tidy.data) #[Gg] = G or g
col.tidy.data <- gsub("-", "_", col.tidy.data) 
col.tidy.data <- gsub("^t", "Time_", col.tidy.data) # ^ = Beginning of the string
col.tidy.data <- gsub("^f", "Freq_", col.tidy.data)
col.tidy.data <- gsub("__", "_", col.tidy.data)
col.tidy.data <- gsub("BodyBody", "Body", col.tidy.data)
col.tidy.data <- gsub("mean", "Mean", col.tidy.data)
col.tidy.data <- gsub("std", "Std.", col.tidy.data)
col.tidy.data <- gsub("[(|)]", "", col.tidy.data)

colnames(tidy.data) <- col.tidy.data

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)

## The means of variables by two groups, subjects and activities
### The means of variables by subject_id
ddply(tidy.data, .(subject_id), colwise(mean))
### The means of variables by act_type (actvitiy types)
ddply(tidy.data, .(act_type), colwise(mean))

##preparation for combining the means of the two groups by matching columns
### for the subject
dd1<-ddply(tidy.data, .(subject_id), colwise(mean))
dd1$act_id <-NULL #remove act_id column
names(dd1)[1] <- "id" #rename first column with "id"
dd1.subject <- cbind(type="subject", dd1) #add the type column

###for the activity
dd2<-ddply(tidy.data, .(act_id), colwise(mean))
dd2$subject_id <- NULL #remove subject_id column
names(dd2)[1] <-"id" #rename first column with "id"
dd2.active <- cbind(type="activity", dd2) #add the type column

##combining
tidy.data.avg <- rbind(dd1.subject, dd2.active)
tidy.data.avg$act_type <- NULL

write.table(tidy.data.avg, "./tidy_data_avg.txt", row.names=F, sep="\t") 







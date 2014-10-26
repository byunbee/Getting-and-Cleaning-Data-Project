#Getting and Cleaning Data Project

##Introduction

This repository contains the project for the course of "Getting and Cleaning Data," a part of the Data Science specialization series provided by Johns Hopkins University on Coursera. This course project requires to create a tidy dataset to prepare for later analysis, from a raw dataset of an experiment that obtained information of human activities by smartphones. Detailed information about the experiment and dataset can be found at [The UCI Machine Learning Repository] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 

##About the raw dataset

The raw data for this project can be found [here] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). After unzipping it, a folder, "UCI HAR Dataset," which contains subfolders and raw data files will be found. Two subfolders, indicating where the data were collected from, have two main data files "X_train.txt" in the train folder and "X_test.txt" in the test folder. These datasets are not labeled, but have separate label files formmated as txt, such as features, subject_train, subject_test, y_train, y_test, and activity_labels. The course project requires to combine these txt files appropriately for subsquent analysis. 

##About the course project

This project requires to create one R script called run_analysis.R that does the following: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Besides, the code that created above should be submitted to a Github. 







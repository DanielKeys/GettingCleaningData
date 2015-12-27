---
title: "README.md"
output: html_document
---

The data used for this project comes from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

When unzipped, that file will yield a folder called, "UCI HAR Dataset". This should be used as the working directory in R when running the script.

There is only one R script used for cleaning the data, specifically run_analysis.R - simply run this program (in R Studio or R) and it will write the altered data to the file tidy.txt

No other actions are needed, save perhaps clearing the environment. The code combines training and test data after giving each of them their subject ID and activity information. From this big table, another is extracted containing what I decided were "the measurements on the mean and standard deviation for each measurement." Names are made descriptve by expanding abbreviations, replacing activity numbers with their names, and in general bringing the variables into accordance with the principles of tiny data. (See lecture 4.1, slide 16, as well as 1.3.) A small output table is then created with the desired "average of each variable for each activity and each subject." For a fuller explanation of what the code does, see CodeBook.md
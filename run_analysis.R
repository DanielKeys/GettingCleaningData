X_test <- read.table("~/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
X_train <- read.table("~/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
y_train <- read.table("~/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
y_test <- read.table("~/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
subject_train <- read.table("~/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
subject_test <- read.table("~/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
activity_labels <- read.table("~/UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")
features <- read.table("~/UCI HAR Dataset/features.txt", quote="\"", comment.char="")

##put all data in one table, "big"
btest<- cbind(subject_test, y_test, X_test)
btrain<- cbind(subject_train, y_train, X_train)
big<- rbind(btest, btrain)

##create logical vector identifying relevant features
fm<- grepl("mean", features[,2])
fstd<- grepl("std", features[,2])
fwantn<- fm | fstd
##and another logical identifying desired columns of big data
want<- c(T, T, fwantn)

##subset "measurements on mean and standard deviation for each measurement"
medium<- big[,want]

##give activities descriptive labels
medium[,2]<- activity_labels[medium[,2],2]

##find original variable names
variables<- features[fwantn,2]
variables<- droplevels(variables)
##include first two columns
variables<- c("subjectid", "activity", as.character(variables))

#fix names
variables<- tolower(variables)
variables<- sub("bodybody","body", variables,)
variables<- sub("acc","acceleration", variables,)
variables<- sub("mag","magnitude", variables,)
variables<- sub("gyro","gyroscope", variables,)
variables<- sub("-x","xaxissignal", variables,)
variables<- sub("-y","yaxissignal", variables,)
variables<- sub("-z","zaxissignal", variables,)
variables<- gsub("-", "", variables,)
variables<- sub("std()","standarddeviation", variables,)
variables<- sub("freq()","frequency", variables,)
variables<- gsub("()", "", variables, fixed = T)
variables<- sub("^t", "", variables, perl = T)
variables<- sub("^f", "fastfouriertransform", variables, perl = T)

colnames(medium)<- variables

small<- NULL
for (i in 1:30) {
  subtable<- NULL
  arow<- NULL
  for (a in activity_labels$V2) {
    arow[1]<- i
    arow[2]<- a
    arow[3:81]<- colMeans(
      medium[medium$subjectid==i & medium$activity==a, 3:81])
    if (is.null(subtable)) {
      subtable<- arow
    }
    else {
      subtable<- rbind(subtable, arow)
    }
  }
  if (is.null(small)) {
    small<- subtable
  }
  else {
    small<- rbind(small, subtable)
  }
}

#convert to data frame for write.table
small<- as.data.frame(small, row.names = 1:180, optional = T)
#give it correct column names, mostly averages of medium's variables
for (j in 3:81) {
  variables[j]<- paste0("meanof", variables[j])
}

colnames(small)<- variables

#output tidy data set
write.table(small, file = "tidy.txt", row.names = F)
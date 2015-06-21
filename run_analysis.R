
library(dplyr)

##First, read in the files that contain the data

traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")

##Then, use rbind to merge the two data sets into one (Instruction #1)

totaldata <- rbind(traindata,testdata)

##Name the columns so that we can choose just the mean and std ones

colnames <- read.table("./UCI HAR Dataset/features.txt")
names(totaldata) <- colnames[,2]

##There are some duplicate column names, so in order to use select(),
##make sure that all column names are unique

valid_column_names <- make.names(names=names(totaldata), unique=TRUE, allow_ = TRUE)
names(totaldata) <- valid_column_names

##Then just select the columns that contain either a mean or an std (Instruction #2)

justmeanstd <- select(totaldata,contains(".mean."),contains(".std."))

##Now, in order to give descriptive activity names (Instruction #3), use
##the y_test/train files, and since we'll need the subject later, let's throw
##it in now:

testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

subjectdata <- rbind(trainsubject,testsubject)

testactivity <- read.table("./UCI HAR Dataset/test/y_test.txt")
trainactivity <- read.table("./UCI HAR Dataset/train/y_train.txt")

activitydata <- rbind(trainactivity,testactivity)

##cbind them on

describeddata <- cbind(subjectdata,activitydata,justmeanstd)

##Name the new columns

newnames <- c("Subject","Activity",names(describeddata[,3:68]))
names(describeddata) <- newnames

##Name the activities by changing factor levels,
##so first, set the Activity column as a factor

describeddata$Activity <- as.factor(describeddata$Activity)

##Bring in the activity_label data and assign the values of the second column
##as the factor levels

activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activitynames <- activitylabels[,2]
levels(describeddata$Activity) <- activitynames

##Because the columns were labelled earlier, the variables already have
##descriptive variable names (Instruction #4)

##Creating a tidy data set with the average of each variable for each activity
##and each subject

tidydata <- describeddata %>% group_by(Activity,Subject) %>% summarise_each(funs(mean))

##Now, write it to a table, and write the code to pull it

write.table(tidydata,file="tidydata.txt",row.name=FALSE)
data <- read.table("tidydata.txt",header=TRUE)
View(data)

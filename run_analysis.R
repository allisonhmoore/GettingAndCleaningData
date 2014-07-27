### Allison Moore
### Coursera course project for "Getting and Cleaning Data"

# This script does the following:
#       1. Downloads smartphone data
#       2. Extracts the measurements on the mean and standard deviation for each measurement. 
#       3. Renames variables and labels for easy readability.
#       4. Merges the training and the test sets to create one data set.
#       5. Creates a second, independent tidy data set with the average of each variable for 
#               each activity and each subject.

# (1) Obtain data sets. A full description of the data is available here:
#       http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
if(!file.exists("data")){
        dir.create("data")
}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(fileURL, destfile="./data/smartphones.zip", method="curl")
unzip("./data/smartphones.zip", exdir="./data")

# Read in six data sets; three for train and three for test. (Note that data from the folders 
# "test/Inertial Signals" and "train/Inertial Signls" folders is not read in. This is because 
# it is raw data that does not contain mean or stddev measurments, so we omit it.
testData <- read.table("./data/UCI\ HAR\ Dataset/test/X_test.txt", stringsAsFactors = FALSE)
testSubjectLabels <- read.table("./data/UCI\ HAR\ Dataset/test/subject_test.txt", stringsAsFactors = FALSE)
testActivityLabels <- read.table("./data/UCI\ HAR\ Dataset/test/y_test.txt", stringsAsFactors = FALSE)
trainData <- read.table("./data/UCI\ HAR\ Dataset/train/X_train.txt", stringsAsFactors = FALSE)
trainSubjectLabels <- read.table("./data/UCI\ HAR\ Dataset/train/subject_train.txt", stringsAsFactors = FALSE)
trainActivityLabels <- read.table("./data/UCI\ HAR\ Dataset/train/y_train.txt", stringsAsFactors = FALSE)

# Additionally, read in the data from "features.txt." This is a two-column data set, where 
# the second column provides a list of descriptive variable names for the 561 variables 
# shared by the six data sets above.
features <- read.table("./data/UCI\ HAR\ Dataset/features.txt")
varNames <- as.vector(features[,2])

# (2) Extract variables for mean and stddev measurements.
# First, determine which variable names correspond to mean or standdev measuremens.
# Note the grep will extract meansurements of mean(), std() and  also meanFreq(), 
# which is also a mean measurement.
pattern <- "mean|std"
relevantVariables <- grepl(pattern, varNames)
# Second, extract relevant measurements from testData and trainData.
relevantTestData <- testData[, relevantVariables]
relevantTrainData <- trainData[, relevantVariables]
# Clean out big data sets from memory that are no longer needed.
rm(testData); rm(trainData)

# (3) Rename variables and labels.
# Rename variables in relevantTestData and relevantTrainData.
colnames(relevantTestData) <- varNames[relevantVariables]
colnames(relevantTrainData) <- varNames[relevantVariables]
# Reshape relevantTestData and relevantTrainData to include the subject and activity 
# labels from their respective corresponding datasets.
relevantTestData$Subject.Label <- testSubjectLabels[,1]
relevantTestData$Activity.Label <- testActivityLabels[,1]
relevantTrainData$Subject.Label <- trainSubjectLabels[,1]
relevantTrainData$Activity.Label <- trainActivityLabels[,1]

# (4)  Merge the test and training data sets.
# This is not a "merge" per se but merely a row bind. This is because the two data sets 
# contain distinct observations along identical sets of (originally 561, now 81) variables.
fullData <- rbind(relevantTestData, relevantTrainData)

# (3) Relabeling and tidying:
descriptor <- c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying")
varList <- lapply(fullData[,81], function(x) descriptor[x])
fullData$Activity <- unlist(varList)
# Move columns and exclude Activity.Label column.
fullData <- cbind(fullData[,c(80,82)], fullData[,1:79])

## Alternatively,could  replace numeric activity labels with descriptive character labels 
## using replace()
# fullData[,2] <- replace(fullData[,2], which(fullData[,2]==1), "walking")
# fullData[,2] <- replace(fullData[,2], which(fullData[,2]=="2"), "walking_upstairs")
# fullData[,2] <- replace(fullData[,2], which(fullData[,2]=="3"), "walking_downstairs")
# fullData[,2] <- replace(fullData[,2], which(fullData[,2]=="4"), "sitting")
# fullData[,2] <- replace(fullData[,2], which(fullData[,2]=="5"), "standing")
# fullData[,2] <- replace(fullData[,2], which(fullData[,2]=="6"), "laying")

# (5) Creates independent tidy data set with the average of each variable for 
# each activity and each subject.
library(reshape2)
dataMelt <- melt(fullData, id.vars=1:2)
tidyData <- dcast(dataMelt, Activity + Subject.Label ~ variable, mean)
write.table(tidyData, "./data/tidyData.txt", row.names=FALSE)

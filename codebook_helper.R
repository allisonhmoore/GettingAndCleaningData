# This script automatically generates text for the codebook describing each of the variables 
# in the "tidyData.txt,"  the dataset produced by run_analysis.R. The formatted codebook as
# a final product is available in the markdown file "codebook.md."


# Load all the coded variable names
codebookText <- read.table("./data/codes.txt")

# Description pieces
fourier <- "The prefix \"f\" rather than \"t\" (time) indicates that this measurement is a frequency domain signal, obtained by applying a Fast Fourier Transform."
Acc <- "The measurement comes from the 3-axial accelerometer"
Gyro <- "The measurement comes from the 3-axial gyroscope"
X <- ", with raw signal in the -X direction."
Y <- ", with raw signal in the -Y direction."
Z <- ", with raw signal in the -Z direction."
Mag <- ", with raw signals measured the -X, -Y, and -Z direction, and magnitude (Mag) of these three-dimensional signals calculated using the Euclidean norm."
BodyAcc <- "The accelerometer signal was separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz. This measures the body signal."
GravityAcc <- "The acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. This measures the gravity signal."
AccJerk <- "Subsequently, the body linear acceleration was derived in time to obtain Jerk signal."
GyroJerk <- "Subsequently, the angular velocity was derived in time to obtain Jerk signal."
meanSent <- "The measurememnt recorded in the original (Version 1.0) dataset estimated the mean of these signals. The measurement that you see in the tidy datset (Version 2.0) calculates the average of all such measurements for each subject label and each activity"
stdSent <- "The measurememnt recorded in the original (Version 1.0) dataset estimated the standard deviation of these signals. The measurement that you see in the tidy datset (Version 2.0) calculates the average of all such measurements for each subject label and each activity"

# Function that pieces together the appropriate description.
describer_function <- function(x, variableDescription = "The measurement is a time domain signal captured at a constant rate of 50 Hz. Measurement was filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.") {
        sentence <- variableDescription
        if (any(grepl("^f", x))) sentence <- paste(sentence, fourier)
        if (any(grepl("Acc", x))) sentence <- paste(sentence, Acc)
        if (any(grepl("Gyro", x))) sentence <- paste(sentence, Gyro)
        if (any(grepl("-X", x))) sentence <- paste(sentence, X, sep="")
        if (any(grepl("-Y", x))) sentence <- paste(sentence, Y, sep="")
        if (any(grepl("-Z", x))) sentence <- paste(sentence, Z, sep="")
        if (any(grepl("Mag", x))) sentence <- paste(sentence, Mag, sep="")
        if (any(grepl("BodyAcc", x))) sentence <- paste(sentence, BodyAcc)
        if (any(grepl("GravityAcc", x))) sentence <- paste(sentence, GravityAcc)
        if (any(grepl("AccJerk", x))) sentence <- paste(sentence, AccJerk)
        if (any(grepl("GyroJerk", x))) sentence <- paste(sentence, GyroJerk)
        if (any(grepl("mean", x))) sentence <- paste(sentence, meanSent)
        if (any(grepl("std", x))) sentence <- paste(sentence, stdSent)
        sentence
}

# # Example function calls.
# test1 <- "fBodyAccJerk-meanFreq()-Z"
# test2 <- "fBodyBodyGyroJerkMag-meanFreq()"
# test3 <- "tBodyAccJerkMag-mean()"
# describer_function(test1, variableDescription)
# describer_function(test2, variableDescription)
# describer_function(test3, variableDescription)

newColumn <- unlist(lapply(codebookText[,1], describer_function))
codebookText$Description <- unlist(lapply(codebookText[,1], describer_function))
head(codebookText)
codebookText[2, 2]
library(xtable)
xt <- xtable(codebookText, caption="Codebook for Version 2.0 (Tidy Version) of Smartphone Dataset")
write(print(xt, type="HTML"), "./data/codebookXT.html")
write.csv(codebookText, "./data/codebook.csv")

# Human Activity Recognition Using Smartphones Dataset
# Version 2.0
### A script to tidy the "Human Activity Recognition Using Smartphones Dataset, Version 1.0"
### and codebook describing the variables in Version 2.0 (tidied dataset)

### This repo contains three files:
------------
* run_analysis.R -- this is script which downloads a certain set of smartphone data, then 
merges and tidies the data sets and produces a single, tidy dataset summarizing some of the
variables.
* codebook.md -- a codebook describing the variables in the tidy dataset
* README.md -- this file.

### Information about run_analysis.R
------------
This script does the following:
       1. Downloads smartphone data from the Version 1.0 files.
       2. Extracts the measurements on the mean and standard deviation for each measurement. 
       3. Renames variables and labels for easy readability.
       4. Merges the training and the test sets to create one data set.
       5. Returns a second, independent tidy data set with the average of each variable for 
               each activity and each subject.

It requires the library reshape2 to be installed in order to melt/cast data sets.

### Information about the tidy dataset produced by run_analysis.R.
The run_analysis.R script produces a tidy dataset of observations and 82 variables. The first two variables (columns 1 and 2) describe a
subject label and activity. Subject labels range between  1 and 30 (that is, there were 30 participants in the study) and the given activity 
is one of six types (walking, walking upstairs, walking downstairs, sitting, standing, laying). For each subject label and activity, the remaining 79 variables each provide an average value of a certian kind of measurement. 

Detailed information about the variables, the data, and transformations applied to clean up the data is available in CodeBook.md.

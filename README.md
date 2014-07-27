## Human Activity Recognition Using Smartphones Dataset
#### Version 2.0

A script to tidy the "Human Activity Recognition Using Smartphones Dataset, Version 1.0" and codebook describing the variables in Version 2.0 dataset (tidied dataset)

### This repo contains four files:
------------
* README.md -- this file.
* run_analysis.R -- this is script which downloads a certain set of smartphone data, then 
        merges and tidies the data sets and produces a single, tidy dataset summarizing some 
        of the variables.
* CodeBook.md -- a codebook describing the variables in the tidy dataset
* codebook_helper.R -- an optional helper file that programmatically creates the variable descriptions 
        seen in Codebook.md.

### Information about run_analysis.R
------------
This script does the following:
       1. Downloads smartphone data from the Version 1.0 files.
       2. Extracts the measurements on the mean and standard deviation for each measurement (including meanFreq                 
                measurements). 
       3. Renames variables and labels for easy readability.
       4. Merges the training and the test sets to create one data set.
       5. Further tidies the data, giving descriptive labels.
       5. Returns a second, independent tidy data set with the average of each variable for 
               each activity and each subject.

It requires the library reshape2 to be installed in order to melt/cast data sets.

For more detail about the data cleaning performed, please see CodeBook.md and the comments in run_analysis.R

### Information about the tidy dataset produced by run_analysis.R.
------------
The run_analysis.R script produces a tidy dataset of 180 observations and 81 variables. The first two variables (columns 1 and 2) describe an activity and subject. Subject labels range between  1 and 30 (that is, there were 30 participants in the study) and the given activity is one of six types (walking, walking upstairs, walking downstairs, sitting, standing, laying). For each subject label and activity, the remaining 79 variables each provide an average value of a certian kind of measurement extracted from the original data. 

Detailed information about the variables, the data, and transformations applied to clean up the data is available in CodeBook.md.

### Information about codebook_helper.R
------------
This script takes descriptions about the data from the original source data files, and complies an
appropriate description for each of the variables appearing in the tidy dataset. It produces a file
called codebookTemp.txt which may then be copy and pasted to augment CodeBook.md appearing in this repo.

###Project ReadME

In addition to this README, there are two files in this repo. One is an R script titled run_analysis.R, which performs the following steps on UCI HAR Dataset"

1. Read in the files that contain the measurements taken during the experiment - x_train and x_test - and clip them together into one data frame.
2. Using the features file, add names to the columns. Then use those names to strip out only the columns with means and standard deviations. These are the columns that utilize the variables mean() and std(), so you'll notice meanFreq() measurements are excluded.
3. Using the y_test and y_train files, name each activity for each observation. Using the subject_test and subject_train files, indicate the subject for each observation.
4. Change the activities from their key to the actual name using activity_labels data.
5. From this tidy data set (each column holds a different variable, and each row is a unique obervation), summarize the mean of each variable, grouping by subject and activity.

The other file is a codebook explaining the variables used in the final product.

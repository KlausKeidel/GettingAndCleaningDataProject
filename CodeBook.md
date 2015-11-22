# CodeBook

A decribtion of the data, the transformation and the variables used by run_analysis.R to create an tidy-data output textfile.

### Based on the Data Source

[Project Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

[Data Set Description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Information about the Data Set

#### Input Data

  * X_train.txt variable features that are intended for training.
  * y_train.txt ativities corrensponding to X_train.txt.
  * subject_train.txt information of the subjects whom's data is collected.
  * X_test.txt  variable freatures that are intended for testing.
  * y_test.txt  corresponding variables to X_text.txt
  * subject_test.txt  subjects information whom's data are collected.
  * activity_labels.txt metadata about different types of activities.
  * features.txt  name of the features in the data sets.

#### Transformations

  * t1_xtrain table variable to read in the X_train.txt file
  * t2_xtest  table variable to read in the x_test.txt file
  * t1_ytrain table variable to read in the y_train.txt file
  * t2_ytest  table variable to read in the y_text.txt file
  * t1_strain table variable to read in the subject_train.txt file
  * t2_stest  table variable to read in the subject_test.txt file
  * features  table variable to read in the features.txt file
  * activity-lables  table variable to read in the activity_lable.txt file
  * X_features, S_subject, Y_activity, features are merged data set from the variables above
  * DataSet is a completed merge from the X_features, S_subject, Y_activity
  * StdColmean  contains the Indices of columns std or mean
  * filter_of_redCols vector variable of StdColmean
  * x_Data is contains the columns filtered by filter_of_redCols variable
  * x_Data are updated by activity_lables to get descriptive names of activities.
  * Variable names are replaced with descriptives lables by names()
  * A tidyData-Set will be created and sorted with the mean for each Subject and Activity
  * An output-file will be written into tidy_data_set.txt an saved on the loacal drive
  
### Dataoutput Set

The columns are delimited by space. The columns are named by the variables-names and containing the mean and the standard values for the tidy_d dataset. 

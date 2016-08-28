Enter file contents here# CodeBook to run_analysis.R


## Used data from the UCI HAR dataset

* features.txt (contains the names of all included features)

* activity_labels.txt (contains the dictionary of activity_id to activity_label)

* X_train.txt (training data)

* X_test.txt (testing data)

* subject_train.txt (subject ids for training data)

* subject_test.txt (subject ids for testing data)

* y_train.txt (contains activity ids for each data set in the training data)

* y_test.txt (contains activity ids for each data set in the testing data)

## Used variables

* output: Result data frame that contains the means of all features for each activity and participant

* subject_id: The numerical id of the subject taking part in the survey

* activity_label: Activity label of the activity carried out
  This variable is first used as a numerical code and is subsequently translated to a character variable using activity_labels.txt

* mean_and_stddev_measurements: A matrix of the means and standard deviations of all parameters measured in the survey
*_idx: Row or column indices used for sorting


## Workflow
The workflow of the code mainly consists of three steps (a high-level representation of the 6 steps in README.md):

1. Load all data (lines 13-36)

2. Merge and select data (lines 38-72)

3. Aggregate to mean (lines 74-90).

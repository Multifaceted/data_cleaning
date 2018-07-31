The program does the following:
1. Download dataset if not existing.
2. Add variable names ('features.txt') to the training set ('X_train.txt') and test set 'X_test.txt').
3. Add variables y ('y_train.txt') and sub ('subject_train.txt') to the training set.
4. Add variables y ('y_test.txt') and sub ('subject_test.txt') to the test set.
5. Merge the training set and the test set, and then write it (data.csv) out.
6. Calculate mean (avg) and standard deviation (std) for each measurement.
7. Creates a second, independent tidy data set (res) with the average of each variable for each activity and each subject, and then write it (result.csv) out.

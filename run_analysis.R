library(tidyverse)

# Please make sure you are in the desired working directory
# before executing this line

if(!file.exists('dataset.zip')){
  download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 'dataset.zip')
  unzip('dataset.zip')}

var <- read_table('./UCI HAR Dataset/features.txt', col_names = FALSE)[[1]] # variable name
train <- read_table('./UCI HAR Dataset/train/X_train.txt', col_names = var)
train_sub <- read_table('./UCI HAR Dataset/train/subject_train.txt', col_names = FALSE)[[1]] # subject code
train <- mutate(train, sub = train_sub)
test <- read_table('./UCI HAR Dataset/test/X_test.txt',  col_names = var)
test_sub <- read_table('./UCI HAR Dataset/test/subject_test.txt',  col_names = FALSE)[[1]]
test <- mutate(test, sub = test_sub)
lab <- read_table('./UCI HAR Dataset/activity_labels.txt', col_names = FALSE)[[2]] # status name
y_train <- factor(read_table('./UCI HAR Dataset/train/y_train.txt', col_names = FALSE)[[1]], labels = lab) # status
y_test <- factor(read_table('./UCI HAR Dataset/test/y_test.txt', col_names = FALSE)[[1]], labels = lab)
train <- mutate(train, y = y_train)
test <- mutate(test, y = y_test)

# Now we have a training set and a test set each with 561 variables(X), one status(y) and one subject.

sum(names(train) != names(test)) # The variable names of training test and test set are exactly the same
data <- bind_rows(train, test)
write_csv(data, 'data.csv')

average <- map_df(data[1: (length(data) - 2)], mean)
std <- map_dbl(data[1: (length(data) - 2)], sd)

data_split <- split.data.frame(data, list(data$y, data$sub)) # split the data.frame accoding to activities and subjects
# data_plist is a list of 180 (30 subjects * 6 activities) elements, each of which is a data.frame of 563 variables.
res <- map_df(data_split, function(y){map_dbl(y[1: (length(y) -2 )], mean)}) 
# res is a list of 180 elements, each  of which is a data.frame of 561 vriables (excluding two grouping factors) and 180 observations
res <- res %>%
  mutate(var = var) %>%
  select(var, everything())
write.table(res, 'result.txt', row.names = FALSE)

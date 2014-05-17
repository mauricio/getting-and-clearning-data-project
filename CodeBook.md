# Codebook for the tidy dataset from motion data

This codebook contains the information about the data processing that was done for the assignment at the [Getting and Cleaning Data course](https://www.coursera.org/course/getdata).

The process of getting and cleaning the data wasn't complicated. First, we had to figure out the columns we wanted to process (only the `mean` and `std` ones), to do this, every column name was checked so we could find the ones that were either means or or standard deviations.

With this information, we loaded the activity label data so we could match it with the activities available at the measurements.

The interesting pieces of the measurements where the following files:

* `X_{type}.txt` - this file contained the actual measurements for all 561 fields, this is the _meat_ of the data;
* `Y_{type}.txt` - this file contained the _activity_ number of each measurement. The data available here had to be merged into the measurements from the previous file;
* `subject_{type}.txt` - this file contained the subject number for each measurement. The data here also had to be merged to the original measurement so we could know the subject that was measured there;

## Pulling and merging the data

The actual process is like this:

* Load all the data from the `X` file;
* Pick only the columns we care about (the `mean` and `std` ones);
* Match the rows from the `X` data frame with the `Y` data frame, including the _activity name_ on every row;
* Match the rows from the `X` data frame with the numbers at the `subject` data frame, this shows who made each activity;

We do this for the `train` data frame and then for the `test` data frame. With both loaded, we merge them into a single data frame and then do the summarisation.

In this case, since we used `plyr`, the summarisation was extremely simple, we split the data in groups by `activity` and `subject` and calculate the `colMeans` for every grouping. As a result, we have our final data frame with 180 rows, since we have 6 different activities for 30 subjects (6 * 30 == 180).

## Column description

The columns available at the resulting data frame are as follows:

* "activity" - the name of the activity being performed, possible values are WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING;
* "subject" - the number of the test subject that performed the activities. There were 30 people being measured, so the values go from 1 to 30;
* All other columns - these are the means for actual measurement columns grouped by `activity` and `subject`, so they represent the mean of that specific column for _one single subject_ performing _one single action_;

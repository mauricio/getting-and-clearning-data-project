# Project assignment for the Getting and Cleaning data class on Coursera

This repo contains the `run_analysis.R` file that is capable of producing the tidy dataset as requested by the assignment project. To be able to run this this script you have to download the assignment data from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and the folder has to be renamed to `uci-har`.

If you are pulling this repo yourself, the data is already available at the `uci-har` folder, so you only need to download the data above if you're copying the script only to run.

The script also makes use of the [plyr](http://plyr.had.co.nz/) library (it's required right at the first line), so make sure you have it installed before sourcing the script file.

For more information about the dataset itself, check the [CodeBook.md](CodeBook.md) file.

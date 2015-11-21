Code in run_analysis.R accomplishes the following:
1. Merges the *test* and *train* data in the UCI HAR Dataset found at the following [location]
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. Merging is done in the following sequence
	* Binding rows of all measurements
	* Obtaining names of all measurement variables and cleaning up the names
	* Renaming column names with variable names
	* Subsetting the columns to include only variables containing *mean* and *std*
	* Binding rows of all activities 
	* Binding rows of all participants (*aka* subjects)
	* Binding columns of participants, activities, and measurements
3. Grouping by participants and activity
4. summarizing by applying mean to all measurements
5. Adding a descriptive column of activity using lookup table for activity id
6. Dropping activity id column and rearranging the columns and arranging by participant
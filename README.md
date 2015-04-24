# Samsung-Data-Analysis
Getting And Cleaning Data Course Project

1. Merge test data in test under dataset.
2. Merge training data under dataset1.
3. Merge dataset and dataset1 into one data frame using rbind and store it into mergedData.
4. Label the User and Activity columns with proper names.
5. Compute the means and standard deviations of the rows and write the result in two new respective columns.
6. Select User, Activity, Mean and Standard Deviation (SD) columns and overwrite mergedData.
7. Add activity names. Get the ordered list from the directory and add a new column ActivityLabel which writes the label according to the Activity column value.
8. Create new dataset called tidyData by finding the average of each Activity of each User. Use group_by to group by User and ActivityLabel, find the average of Mean and SD and then collapse repeated variables using unique(). Then arrange the data by User and Activity.

##You should create one R script called run_analysis.R that does the following. 
##Merges the training and the test sets to create one data set.
##Extracts only the measurements on the mean and standard deviation for each measurement. 
##Uses descriptive activity names to name the activities in the data set
##Appropriately labels the data set with descriptive variable names. 
##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#First, set working directory one level from UCI HAR Dataset :)
rm(list=ls())
library(dplyr)
library(tidyr)

#Merge
file_list <- list.files("./UCI HAR Dataset/test")
for (file in file_list[2:4]){    
  if (!exists("dataset")){
    dataset <- read.table(file.path("./UCI HAR Dataset/test",file))
  }
  else {
    temp_dataset <-read.table(file.path("./UCI HAR Dataset/test",file))
    dataset<-cbind(dataset, temp_dataset)
    rm(temp_dataset)
  } 
}

file_list <- list.files("./UCI HAR Dataset/train")
for (file in file_list[2:4]){
       
  # if the merged dataset doesn't exist, create it
  if (!exists("dataset1")){
    dataset1 <- read.table(file.path("./UCI HAR Dataset/train",file))
  }
  else {
    temp_dataset <-read.table(file.path("./UCI HAR Dataset/train",file))
    dataset1<-cbind(dataset1, temp_dataset)
    rm(temp_dataset)
  }
}

mergedData <- rbind(dataset, dataset1)
mergedData <- mergedData[,c(1,563,2:562)]
colnames(mergedData)[1:2] <- c("User", "Activity")

#Extracts Mean and Sd
mergedData <- transform(mergedData, Mean = rowMeans(mergedData[,3:563]), SD = apply(mergedData, 1, sd))
mergedData <- select(mergedData, User, Activity, Mean, SD)

#Add Activity Names
labels <- data.frame(read.table("./UCI HAR Dataset/activity_labels.txt")[,2])
colnames(labels) <- "Activity_Label"
mergedData <-  mutate(mergedData, ActivityLabel = labels$Activity_Label[mergedData[,2]])

#Tidy Dataset
tidyData <- mergedData %>%
group_by(User, ActivityLabel) %>% 
mutate(AverageMean = mean(Mean), AverageSD = mean(SD)) %>%
select(User,Activity,ActivityLabel,AverageMean,AverageSD)%>%
unique() %>%
data.frame() %>%
arrange(User, Activity) %>%
select(User, ActivityLabel, AverageMean, AverageSD)

rm(dataset, dataset1, mergedData)
print(tidyData)

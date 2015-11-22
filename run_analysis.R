library(dplyr)
setwd("C:/R/CleaningData/Project/UCI HAR Dataset")
#Read training data
Xtrain <- read.table("train/X_train.txt")
ytrain <- read.table("train/y_train.txt")
SubTrain <- read.table("train/subject_train.txt")
#Read test data
Xtest <- read.table("test/X_test.txt")
ytest <- read.table("test/y_test.txt")
SubTest <- read.table("test/subject_test.txt")
#Read features and activity labels
f <- read.table("features.txt")
ActLabels <- read.table("activity_labels.txt")
#Merge rows of subject, X train/test, y train/test
SubTrainTest <- rbind(SubTrain, SubTest)
XTrainTest <- rbind(Xtrain, Xtest)
yTrainTest <- rbind(ytrain, ytest)
#Assign names for data
names(SubTrainTest)<-c("subject")
names(yTrainTest)<- c("ID")
names(XTrainTest) <- f$V2
names(ActLabels) <- c("ID", "Name")
#Merge columns together
merge <- cbind(XTrainTest, yTrainTest, SubTrainTest)
#Extract mean and Standard deviation measurenments
ExtractFeatures<-f$V2[grep("mean\\(\\)|std\\(\\)", f$V2)]
SelectFeatures<-c(as.character(ExtractFeatures), "subject", "ID")
merge2<-subset(merge,select=SelectFeatures)
#Join activity names to table
merge3 <- merge(ActLabels, merge2 , by="ID", all.x=TRUE)
merge3$Name <- as.character(merge3$Name)
#Create final merged table
dataAggr<- aggregate(. ~ subject - Name, data = merge3, mean) 
merge4<- tbl_df(arrange(dataAggr,subject,Name))
#write output table to file
write.table(merge4, "FinalDataset.txt", row.name=FALSE)

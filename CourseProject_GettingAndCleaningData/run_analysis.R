mergeData <- function(){
        xTest <- read.table("./UCI HAR Dataset//test//X_test.txt")
        xTrain <- read.table("./UCI HAR Dataset//train//X_train.txt")
        X <- rbind(xTest, xTrain)
        print(dim(X))
        
        yTest <- read.table("./UCI HAR Dataset//test//y_test.txt")
        yTrain <- read.table("./UCI HAR Dataset//train//y_train.txt")
        Y <- rbind(yTest, yTrain)
        print(dim(Y))
        
        subjectTest <- read.table("./UCI HAR Dataset//test/subject_test.txt")
        subjectTrain <- read.table("./UCI HAR Dataset//train//subject_train.txt")
        subject <- rbind(subjectTest, subjectTrain)
        print(dim(subject))
        
        merged <- cbind(X, subject, Y)
        
        featureNames <- read.table("./UCI HAR Dataset/features.txt")
        names(merged) <- c(as.character(featureNames$V2), "subject", "activity")
        
        merged <- merged[, grepl("mean()", names(merged)) | grepl("std()", names(merged)) | grepl("subject", names(merged)) | grepl("activity", names(merged))]
        
        merged <- merged[, unique(colnames(merged))]
        
        return(merged)
}

createAverageDataSet <- function(data){
        library(dplyr)
        groups <- group_by(data, subject, activity)
        avgData <- summarise_each(groups, funs(mean))
}


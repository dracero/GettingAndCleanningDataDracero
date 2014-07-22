#reading the data from the previously downloaded file
test <- read.table("C:/Users/dracero/Downloads/UCI HAR Dataset/test/X_test.txt", quote="\"")
train <- read.table("C:/Users/dracero/Downloads/UCI HAR Dataset/train/X_train.txt", quote="\"")
y_test <- read.table("C:/Users/dracero/Downloads/UCI HAR Dataset/test/y_test.txt", quote="\"")
y_train <- read.table("C:/Users/dracero/Downloads/UCI HAR Dataset/train/y_train.txt", quote="\"")

#adding the activity for each row
test<-cbind(y_test,test)
train<-cbind(y_train,train)

#reading the column labels and the activity names
features <- read.table("C:/Users/dracero/Downloads/UCI HAR Dataset/features.txt", quote="\"")
activity_labels <- read.table("C:/Users/dracero/Downloads/UCI HAR Dataset/activity_labels.txt", quote="\"")

#taking only the mean and standar deviation of each meassure
x<-features[grep("mean()",features$V2),]
y<-features[grep("std()",features$V2),]
z<-rbind(x,y)
z<-z[order(z$V1,na.last=TRUE),]

#merging all data in one dataset
tf<-rbind(train[,c(1,z$V1+1)], test[,c(1,z$V1+1)])

#naming the activities for each row
names(tf)[1]<-"activity"
i <- sapply(z, is.factor)
z[i] <- lapply(z[i], as.character)
names(tf)[2:66]<-z$V2

#deleting the activity numbers and replacing with activity labels
tf2<-merge(tf,activity_labels, by.x="activity", by.y="V1")
tf2$activity<-tf2$V2
tf2$V2<-NULL

#creating the final dataset with the average of each varible for each type of activity
mdata <- aggregate(tf2[,2:66], by=tf["activity"], FUN=mean)






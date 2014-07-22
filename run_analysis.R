test <- read.table("C:/Users/dracero/Downloads/UCI HAR Dataset/test/X_test.txt", quote="\"")
train <- read.table("C:/Users/dracero/Downloads/UCI HAR Dataset/train/X_train.txt", quote="\"")
y_test <- read.table("C:/Users/dracero/Downloads/UCI HAR Dataset/test/y_test.txt", quote="\"")
y_train <- read.table("C:/Users/dracero/Downloads/UCI HAR Dataset/train/y_train.txt", quote="\"")

test<-cbind(y_test,test)
train<-cbind(y_train,train)

features <- read.table("C:/Users/dracero/Downloads/UCI HAR Dataset/features.txt", quote="\"")
activity_labels <- read.table("C:/Users/dracero/Downloads/UCI HAR Dataset/activity_labels.txt", quote="\"")

x<-features[grep("mean()",features$V2),]
y<-features[grep("std()",features$V2),]
z<-rbind(x,y)
z<-z[order(z$V1,na.last=TRUE),]

tf<-rbind(train[,c(1,z$V1+1)], test[,c(1,z$V1+1)])

names(tf)[1]<-"activity"
i <- sapply(z, is.factor)
z[i] <- lapply(z[i], as.character)
names(tf)[2:66]<-z$V2

tf2<-merge(tf,activity_labels, by.x="activity", by.y="V1")
tf2$activity<-tf2$V2
tf2$V2<-NULL

mdata <- aggregate(tf2[,2:66], by=tf["activity"], FUN=mean)






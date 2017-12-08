
library(gmodels)
library(caret)
library(ggplot2)
library(kernlab)
# read arff file
start_time <- Sys.time()
set.seed(800)
ad=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/3-InternetAdvertisementDataSets/ad.arff")
#Clusters can be improved and Different column can be used
#Find Better Factors


adCluster <- kkmeans(as.matrix(ad[,2:3]), centers=2)#kkmeans(iris[, 3:4], 3, nstart = 20)
adCluster
#K-means clustering with 3 clusters of sizes 46, 54, 50
table(adCluster, ad$class)

#Plotting Clusters Issue with the clusters
adClustera<- as.factor(adCluster)
ggplot(ad, aes(width, aratio, color = adClustera)) + geom_point()

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(adCluster)
ptm <- proc.time()
ptm
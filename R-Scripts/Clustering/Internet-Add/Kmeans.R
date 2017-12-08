library(ggplot2)
library(foreign)
library(caret)
library(pryr)
# read arff file
start_time <- Sys.time()
set.seed(800)
ad=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/3-InternetAdvertisementDataSets/ad.arff")
#Clusters can be improved and Different column can be used

adCluster <- kmeans(ad[, 2:3], 2, nstart = 20)
adCluster
#K-means clustering with 3 clusters of sizes 46, 54, 50
table(adCluster$cluster, ad$class)

#Plotting Clusters Issue with the clusters
adCluster$cluster <- as.factor(adCluster$cluster)
ggplot(ad, aes(width, aratio, color = adCluster$cluster)) + geom_point()

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(adCluster)
ptm <- proc.time()
ptm
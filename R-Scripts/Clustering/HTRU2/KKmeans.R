
library(gmodels)
library(caret)
library(ggplot2)
library(kernlab)
library(foreign)
start_time <- Sys.time()
# read arff file
HTRU2=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/HTRU2/HTRU_2.arff")
#Clusters can be improved and Different column can be used
#Find Better Factors

set.seed(800)
HTRU2Cluster <- kkmeans(as.matrix(HTRU2[,7:8]), centers=2)#kkmeans(iris[, 3:4], 3, nstart = 20)
HTRU2Cluster
#K-means clustering with 3 clusters of sizes 46, 54, 50
table(HTRU2Cluster, HTRU2$class)

#Plotting Clusters Issue with the clusters
HTRU2Clustera<- as.factor(HTRU2Cluster)
ggplot(HTRU2, aes(DM_skewness, DM_kurtosis, color = HTRU2Clustera)) + geom_point()

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(HTRU2Cluster)
ptm <- proc.time()
ptm
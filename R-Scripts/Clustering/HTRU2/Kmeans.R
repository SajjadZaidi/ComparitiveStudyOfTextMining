library(ggplot2)

library(caret)
# read arff file
start_time <- Sys.time()
HTRU2=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/HTRU2/HTRU_2.arff")
#Clusters can be improved and Different column can be used
set.seed(800)
HTRU2Cluster <- kmeans(HTRU2[, 7:8], 2, nstart = 20)
HTRU2Cluster
#K-means clustering with 3 clusters of sizes 46, 54, 50
table(HTRU2Cluster$cluster, HTRU2$class)

#Plotting Clusters Issue with the clusters
HTRU2Cluster$cluster <- as.factor(HTRU2Cluster$cluster)
ggplot(HTRU2, aes(DM_skewness, DM_kurtosis, color = HTRU2Cluster$cluster)) + geom_point()

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(HTRU2Cluster)
ptm <- proc.time()
ptm
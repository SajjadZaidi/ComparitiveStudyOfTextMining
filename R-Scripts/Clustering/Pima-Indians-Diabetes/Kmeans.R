library(ggplot2)

library(caret)
# read arff file
start_time <- Sys.time()
diabetes=read.arff(file="D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/-Diabities/diabetes.arff")
#Clusters can be improved and Different column can be used
set.seed(800)
DiabetesCluster <- kmeans(diabetes[, 7:8], 2, nstart = 20)
DiabetesCluster
#K-means clustering with 3 clusters of sizes 46, 54, 50
table(DiabetesCluster$cluster, diabetes$class)

#Plotting Clusters Issue with the clusters
DiabetesCluster$cluster <- as.factor(DiabetesCluster$cluster)
ggplot(diabetes, aes(pedi, age, color = DiabetesCluster$cluster)) + geom_point()

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(DiabetesCluster)
ptm <- proc.time()
ptm
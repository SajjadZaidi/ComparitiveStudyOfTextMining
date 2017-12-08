
library(gmodels)
library(caret)
library(ggplot2)
library(kernlab)
start_time <- Sys.time()
# read arff file
diabetes=read.arff(file="D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/-Diabities/diabetes.arff")
#Clusters can be improved and Different column can be used
#Find Better Factors

set.seed(800)
diabetesCluster <- kkmeans(as.matrix(diabetes[,7:8]), centers=2)#kkmeans(iris[, 3:4], 3, nstart = 20)
diabetesCluster
#K-means clustering with 3 clusters of sizes 46, 54, 50
table(diabetesCluster, diabetes$class)

#Plotting Clusters Issue with the clusters
diabetesClustera<- as.factor(diabetesCluster)
ggplot(diabetes, aes(insu, pedi, color = diabetesClustera)) + geom_point()

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(diabetesCluster)
ptm <- proc.time()
ptm
library(e1071)
# read arff file
start_time <- Sys.time()
diabetes=read.arff(file="D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/-Diabities/diabetes.arff")

set.seed(800)



result <- cmeans(diabetes[,c(7,8)], centers=2, iter.max=100, m=2, method="cmeans")  # 3 clusters
plot(diabetes[,5], diabetes[,7], col=result$cluster)
points(result$centers[,c(1,2)], col=1:3, pch=19, cex=2)

result$membership[1:9,] # degree of membership for each observation to each cluster:

table( result$cluster,diabetes$class)


end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(result)
ptm <- proc.time()
ptm
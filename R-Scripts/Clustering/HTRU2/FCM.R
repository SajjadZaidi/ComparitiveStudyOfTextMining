library(e1071)
start_time <- Sys.time()
# read arff file
HTRU2=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/HTRU2/HTRU_2.arff")

set.seed(800)



result <- cmeans(HTRU2[,-9], centers=2, iter.max=100, m=2, method="cmeans")  # 3 clusters
plot(HTRU2[,5], HTRU2[,7], col=result$cluster)
points(result$centers[,c(1,2)], col=1:3, pch=19, cex=2)

result$membership[1:9,] # degree of membership for each observation to each cluster:

table(HTRU2$class, result$cluster)

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(result)
ptm <- proc.time()
ptm
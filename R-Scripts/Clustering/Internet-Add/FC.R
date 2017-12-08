library(e1071)
# read arff file
start_time <- Sys.time()
set.seed(800)
ad=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/3-InternetAdvertisementDataSets/ad.arff")





result <- cmeans(ad[,2:3], centers=2, iter.max=100, m=2, method="cmeans")  # 3 clusters
plot(ad[,5], ad[,7], col=result$cluster)
points(result$centers[,c(1,2)], col=1:3, pch=19, cex=2)

result$membership[2:3,] # degree of membership for each observation to each cluster:

table(result$cluster,ad$class)

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(result)
ptm <- proc.time()
ptm
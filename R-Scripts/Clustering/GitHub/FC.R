library(e1071)
start_time <- Sys.time()
# read arff file
git = read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/5-Github/Git.csv", stringsAsFactors=F)

set.seed(800)


result <- cmeans(git[,c(3,4)], centers=5, iter.max=100, m=2, method="cmeans")  # 3 clusters
plot(git[,1], git[,8], col=result$cluster)
points(result$centers[,c(3,4)], col=1:2, pch=19, cex=2)

result$membership[c(1,3,4),] # degree of membership for each observation to each cluster:

table(result$cluster,git$Language)

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(gitCluster)
ptm <- proc.time()
ptm
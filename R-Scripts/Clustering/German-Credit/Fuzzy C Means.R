library(e1071)
# read arff file
start_time <- Sys.time()
german_credit=read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/german_credit.csv", stringsAsFactors=F);#read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/credit-g.arff")
german_credit$Creditability=as.factor(german_credit$Creditability)

set.seed(800)



result <- cmeans(german_credit[,c(3,4,5)], centers=2, iter.max=100, m=2, method="cmeans")  # 3 clusters
plot(german_credit[,5], german_credit[,7], col=result$cluster)
points(result$centers[,c(1,2)], col=1:3, pch=19, cex=2)

result$membership[1:9,] # degree of membership for each observation to each cluster:

table( result$cluster,german_credit$Creditability)


end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(result)
ptm <- proc.time()
ptm
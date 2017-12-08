library(ggplot2)

library(caret)
# read arff file
start_time <- Sys.time()
german_credit=read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/german_credit.csv", stringsAsFactors=F);#read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/credit-g.arff")
german_credit$Creditability=as.factor(german_credit$Creditability)
str(german_credit)
#Clusters can be improved and Different column can be used
set.seed(800)
DiabetesCluster <- kmeans(german_credit[, 3:5], 2, nstart = 20)
DiabetesCluster
#K-means clustering with 3 clusters of sizes 46, 54, 50
table(DiabetesCluster$cluster, german_credit$Creditability)

#Plotting Clusters Issue with the clusters
DiabetesCluster$cluster <- as.factor(DiabetesCluster$cluster)
ggplot(german_credit, aes(pedi, age, color = DiabetesCluster$cluster)) + geom_point()

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(DiabetesCluster)
ptm <- proc.time()
ptm
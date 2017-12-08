
library(gmodels)
library(caret)
library(ggplot2)
library(kernlab)
start_time <- Sys.time()
# read arff file
german_credit=read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/german_credit.csv", stringsAsFactors=F);#read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/credit-g.arff")
german_credit$Creditability=as.factor(german_credit$Creditability)
#Clusters can be improved and Different column can be used
#Find Better Factors

set.seed(800)
diabetesCluster <- kkmeans(as.matrix(german_credit[,3:6]), centers=2)#kkmeans(iris[, 3:4], 3, nstart = 20)
diabetesCluster
#K-means clustering with 3 clusters of sizes 46, 54, 50
table(diabetesCluster, german_credit$Creditability)

#Plotting Clusters Issue with the clusters
diabetesClustera<- as.factor(diabetesCluster)
ggplot(diabetes, aes(insu, pedi, color = diabetesClustera)) + geom_point()

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(diabetesCluster)
ptm <- proc.time()
ptm
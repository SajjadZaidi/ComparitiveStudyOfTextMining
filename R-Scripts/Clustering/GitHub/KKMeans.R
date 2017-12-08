
library(gmodels)
library(caret)
library(ggplot2)
library(kernlab)
start_time <- Sys.time()
# read arff file
git = read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/5-Github/Git.csv", stringsAsFactors=F)
#Clusters can be improved and Different column can be used
#Find Better Factors

set.seed(800)
gitCluster <- kkmeans(as.matrix(git[,c(2,4)]), centers=5)#kkmeans(iris[, 3:4], 3, nstart = 20)
#gitCluster
#K-means clustering with 3 clusters of sizes 46, 54, 50
table(gitCluster, git$Language)

#Plotting Clusters Issue with the clusters
gitClustera<- as.factor(gitCluster)
ggplot(git, aes(insu, pedi, color = gitClustera)) + geom_point()

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(gitCluster)
ptm <- proc.time()
ptm
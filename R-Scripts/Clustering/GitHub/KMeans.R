library(ggplot2)
library(pryr)
library(caret)

#Evaluate Performance

start_time <- Sys.time()
git = read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/5-Github/Git.csv", stringsAsFactors=F)

#Clusters can be improved and Different column can be used
set.seed(800)
gitCluster <- kmeans(git[, c(8)], 5, nstart = 20)
str(gitCluster)
#K-means clustering with 3 clusters of sizes 46, 54, 50
table(gitCluster$cluster, git$Language)

#Plotting Clusters Issue with the clusters
gitCluster$cluster <- as.factor(gitCluster$cluster)
ggplot(git, aes(OpenIssues,Network.count , color = gitCluster$cluster)) + geom_point()
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(gitCluster)
ptm <- proc.time()
ptm
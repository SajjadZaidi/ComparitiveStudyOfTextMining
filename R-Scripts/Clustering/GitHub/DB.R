library(fpc)
library(foreign)
# read arff file
start_time <- Sys.time()
git = read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/5-Github/Git.csv", stringsAsFactors=F)




set.seed(800)
samplegit <- git # get samples from iris dataset
# eps is radius of neighborhood, MinPts is no of neighbors within eps
cluster <- dbscan(samplegit[,c(4,7)], eps=0.6, MinPts=8)#change this a little bit
length(cluster$cluster)

# black points are outliers, triangles are core points and circles are boundary points
#plot(cluster, samplediabetes)

#plot(cluster, samplegit[,c(2,8)])

# Notice points in cluster 0 are unassigned outliers
table(cluster$cluster,samplegit$Language )

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(cluster)
ptm <- proc.time()
ptm
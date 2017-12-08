library(fpc)
library(foreign)
# read arff file
# read arff file
start_time <- Sys.time()
HTRU2=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/HTRU2/HTRU_2.arff")

set.seed(800)


sampleHTRU2 <- HTRU2 # get samples from iris dataset
# eps is radius of neighborhood, MinPts is no of neighbors within eps
cluster <- dbscan(sampleHTRU2[,7:8], eps=0.6, MinPts=8)
str(cluster)

# black points are outliers, triangles are core points and circles are boundary points
#plot(cluster, samplediabetes)

plot(cluster, sampleHTRU2[,c(7,8)])

# Notice points in cluster 0 are unassigned outliers
table(cluster$cluster ,sampleHTRU2$class)

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(cluster)
ptm <- proc.time()
ptm

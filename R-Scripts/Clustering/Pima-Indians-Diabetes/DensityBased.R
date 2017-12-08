library(fpc)
library(foreign)
# read arff file
start_time <- Sys.time()
diabetes=read.arff(file="D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/-Diabities/diabetes.arff")



set.seed(800)


samplediabetes <- diabetes # get samples from iris dataset
# eps is radius of neighborhood, MinPts is no of neighbors within eps
cluster <- dbscan(samplediabetes[,c(3,5)], eps=0.6, MinPts=4)
str(cluster)
help("dbscan")
# black points are outliers, triangles are core points and circles are boundary points
#plot(cluster, samplediabetes)

plot(cluster, samplediabetes[,c(5,7)])

# Notice points in cluster 0 are unassigned outliers
table(cluster$cluster,samplediabetes$class )

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(samplediabetes)
ptm <- proc.time()
ptm
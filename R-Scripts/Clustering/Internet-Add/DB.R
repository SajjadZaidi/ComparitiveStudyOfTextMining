library(fpc)
library(foreign)
# read arff file
# read arff file
start_time <- Sys.time()
ad=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/3-InternetAdvertisementDataSets/ad.arff")

#Too many cluster


set.seed(800)
samplead <- ad # get samples from iris dataset
# eps is radius of neighborhood, MinPts is no of neighbors within eps
cluster <- dbscan(samplead[,2:3], eps=0.6, MinPts=8)
str(cluster)

# black points are outliers, triangles are core points and circles are boundary points
#plot(cluster, samplediabetes)

plot(cluster, samplead[,c(2,3)])

# Notice points in cluster 0 are unassigned outliers
table(cluster$cluster, samplead$class)

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(cluster)
ptm <- proc.time()
ptm
library("kohonen")
start_time <- Sys.time()
set.seed(800)
#Add Confusion Matrix
# read arff file
ad=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/3-InternetAdvertisementDataSets/ad.arff")

# scale data
ad.sc = scale(ad[, -1559])

# build grid
ad.grid = somgrid(xdim = 5, ydim=5, topo="hexagonal")

# build model
ad.som = som(ad.sc, grid=ad.grid, rlen=100, alpha=c(0.05,0.01))

diabetes.som

plot(ad.som, type="changes")
# A bunch different Visulaization
plot(ad.som, type="count")
plot(ad.som, type="dist.neighbours")
plot(ad.som, type="codes")
coolBlueHotRed <- function(n, alpha = 1) {rainbow(n, end=4/6, alpha=alpha)[n:1]}
#plot(iris.som, type = "property", property = iris.som$codes[,5], main=names(iris.som$data)[4], palette.name=coolBlueHotRed)

## use hierarchical clustering to cluster the codebook vectors
groups = 2
ad.hc = cutree(hclust(dist(unlist(ad.som$codes))), groups)

# plot
plot(ad.som, type="codes", bgcol=rainbow(groups)[ad.hc])

#cluster boundaries
add.cluster.boundaries(ad.som, ad.hc)

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(gitCluster)
ptm <- proc.time()
ptm
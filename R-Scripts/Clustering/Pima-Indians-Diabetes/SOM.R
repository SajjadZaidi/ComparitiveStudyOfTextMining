library("kohonen")
start_time <- Sys.time()
#Add Confusion Matrix
# read arff file
diabetes=read.arff(file="D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/-Diabities/diabetes.arff")

set.seed(800)
# scale data
diabetes.sc = scale(diabetes[, 1:8])

# build grid
diabetes.grid = somgrid(xdim = 5, ydim=5, topo="hexagonal")

# build model
diabetes.som = som(diabetes.sc, grid=diabetes.grid, rlen=100, alpha=c(0.05,0.01))
diabetes.som

plot(diabetes.som, type="changes")
# A bunch different Visulaization
plot(diabetes.som, type="count")
plot(diabetes.som, type="dist.neighbours")
plot(diabetes.som, type="codes")
coolBlueHotRed <- function(n, alpha = 1) {rainbow(n, end=4/6, alpha=alpha)[n:1]}
#plot(iris.som, type = "property", property = iris.som$codes[,5], main=names(iris.som$data)[4], palette.name=coolBlueHotRed)

## use hierarchical clustering to cluster the codebook vectors
groups = 2
diabetes.hc = cutree(hclust(dist(unlist(diabetes.som$codes))), groups)

# plot
plot(diabetes.som, type="codes", bgcol=rainbow(groups)[diabetes.hc])

#cluster boundaries
add.cluster.boundaries(diabetes.som, diabetes.hc)

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(gitCluster)
ptm <- proc.time()
ptm
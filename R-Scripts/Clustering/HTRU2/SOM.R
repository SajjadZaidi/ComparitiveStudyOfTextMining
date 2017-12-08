library("kohonen")
start_time <- Sys.time()
#Add Confusion Matrix
# read arff file
HTRU2=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/HTRU2/HTRU_2.arff")

set.seed(800)
# scale data
HTRU2.sc = scale(HTRU2[, 1:8])

# build grid
HTRU2.grid = somgrid(xdim = 5, ydim=5, topo="hexagonal")

# build model
HTRU2.som = som(HTRU2.sc, grid=HTRU2.grid, rlen=100, alpha=c(0.05,0.01))
diabetes.som

plot(HTRU2.som, type="changes")
# A bunch different Visulaization
plot(HTRU2.som, type="count")
plot(HTRU2.som, type="dist.neighbours")
plot(HTRU2.som, type="codes")
coolBlueHotRed <- function(n, alpha = 1) {rainbow(n, end=4/6, alpha=alpha)[n:1]}
#plot(iris.som, type = "property", property = iris.som$codes[,5], main=names(iris.som$data)[4], palette.name=coolBlueHotRed)

## use hierarchical clustering to cluster the codebook vectors
groups = 2
HTRU2.hc = cutree(hclust(dist(unlist(HTRU2.som$codes))), groups)

# plot
plot(HTRU2.som, type="codes", bgcol=rainbow(groups)[HTRU2.hc])

#cluster boundaries
add.cluster.boundaries(HTRU2.som, HTRU2.hc)

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(gitCluster)
ptm <- proc.time()
ptm
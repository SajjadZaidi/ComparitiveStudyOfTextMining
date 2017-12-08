library("kohonen")

#Add Confusion Matrix
# read arff file
set.seed(800)
start_time <- Sys.time()
git = read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/5-Github/Git.csv", stringsAsFactors=F)


# scale data
git.sc = scale(git[, 2:7])

# build grid
git.grid = somgrid(xdim = 5, ydim=5, topo="hexagonal")

# build model
git.som = som(git.sc, grid=git.grid, rlen=100, alpha=c(0.05,0.01))
git.som

plot(git.som, type="changes")
# A bunch different Visulaization
plot(git.som, type="count")
plot(git.som, type="dist.neighbours")
plot(git.som, type="codes")
coolBlueHotRed <- function(n, alpha = 1) {rainbow(n, end=4/6, alpha=alpha)[n:1]}
#plot(iris.som, type = "property", property = iris.som$codes[,5], main=names(iris.som$data)[4], palette.name=coolBlueHotRed)

## use hierarchical clustering to cluster the codebook vectors
groups = 2
git.hc = cutree(hclust(dist(unlist(git.som$codes))), groups)

# plot
plot(git.som, type="codes", bgcol=rainbow(groups)[git.hc])

#cluster boundaries
add.cluster.boundaries(git.som, git.hc)

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(gitCluster)
ptm <- proc.time()
ptm
# load the kohonen package
#http://en.proft.me/2016/11/29/modeling-self-organising-maps-r/
library("kohonen")
start_time <- Sys.time()
# Read in `iris` data
iris <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"), 
                 header = FALSE) 

# Print first lines
head(iris)

# Add column names
names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

# scale data
iris.sc = scale(iris[, 1:4])

# build grid
iris.grid = somgrid(xdim = 5, ydim=5, topo="hexagonal")

# build model
iris.som = som(iris.sc, grid=iris.grid, rlen=100, alpha=c(0.05,0.01))
#summary(iris.som$data)
plot(iris.som, type="changes")
# A bunch different Visulaization
plot(iris.som, type="count")
plot(iris.som, type="dist.neighbours")
plot(iris.som, type="codes")
coolBlueHotRed <- function(n, alpha = 1) {rainbow(n, end=4/6, alpha=alpha)[n:1]}
#plot(iris.som, type = "property", property = iris.som$codes[,5], main=names(iris.som$data)[4], palette.name=coolBlueHotRed)

## use hierarchical clustering to cluster the codebook vectors
groups = 3
iris.hc = cutree(hclust(dist(unlist(iris.som$codes))), groups)

# plot
plot(iris.som, type="codes", bgcol=rainbow(groups)[iris.hc])

#cluster boundaries
add.cluster.boundaries(iris.som, iris.hc)

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(gitCluster)
ptm <- proc.time()
ptm
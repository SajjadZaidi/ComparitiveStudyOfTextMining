library(fpc)
#http://www.di.fc.ul.pt/~jpn/r/clustering/clustering.html#density-based-cluster
start_time <- Sys.time()
# Read in `iris` data
iris <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"), 
                 header = FALSE) 

# Print first lines
head(iris)

# Add column names
names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

set.seed(800)
sampleiris <- iris# get samples from iris dataset
# eps is radius of neighborhood, MinPts is no of neighbors within eps
cluster <- dbscan(sampleiris[,-5], eps=0.6, MinPts=3)
# black points are outliers, triangles are core points and circles are boundary points
plot(cluster, sampleiris)

plot(cluster, sampleiris[,c(1,4)])

# Notice points in cluster 0 are unassigned outliers
table(cluster$cluster, sampleiris$Species)


end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(cluster)
ptm <- proc.time()
ptm
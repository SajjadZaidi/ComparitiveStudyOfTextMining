
library(gmodels)
library(caret)
library(ggplot2)
library(kernlab)
#https://www.r-bloggers.com/k-means-clustering-in-r/
start_time <- Sys.time()
# Read in `iris` data
iris <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"), 
                 header = FALSE) 

# Print first lines
head(iris)

# Add column names
names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

#(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point()

set.seed(800)
irisCluster <- kkmeans(as.matrix(iris[,-5]), centers=3)#kkmeans(iris[, 3:4], 3, nstart = 20)
irisCluster
#K-means clustering with 3 clusters of sizes 46, 54, 50
table(irisCluster, iris$Species)

#Plotting Clusters Issue with the clusters
irisCluster$cluster <- as.factor(irisCluster$cluster)
ggplot(iris, aes(Petal.Length, Petal.Width, color = irisCluster$cluster)) + geom_point()

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(irisCluster)
ptm <- proc.time()
ptm
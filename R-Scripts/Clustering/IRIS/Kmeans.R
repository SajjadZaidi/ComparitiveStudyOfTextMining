library(farff)
library(foreign)
library(naivebayes)
library(Formula)
library(magrittr)
library(ggvis)
library(class)
library(gmodels)
library(caret)
library(ggplot2)
#https://www.r-bloggers.com/k-means-clustering-in-r/
# Read in `iris` data
start_time <- Sys.time()
iris <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"), 
 header = FALSE) 

# Print first lines
head(iris)

# Add column names
names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

#(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point()

set.seed(800)
irisCluster <- kmeans(iris[, 3:4], 3, nstart = 20)
irisCluster
#K-means clustering with 3 clusters of sizes 46, 54, 50
table(irisCluster$cluster, iris$Species)
str(irisCluster$centers$)
confusionMatrix(irisCluster$centers, iris[,5])

#Plotting Clusters Issue with the clusters
irisCluster$cluster <- as.factor(irisCluster$cluster)
ggplot(iris, aes(Petal.Length, Petal.Width, color = irisCluster$cluster)) + geom_point()

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(irisCluster)
ptm <- proc.time()
ptm
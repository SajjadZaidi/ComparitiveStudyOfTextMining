#http://www.di.fc.ul.pt/~jpn/r/clustering/clustering.html#fuzzy-c-means
library(e1071)
start_time <- Sys.time()
# Read in `iris` data
iris <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"), 
                 header = FALSE) 

# Print first lines
head(iris)

# Add column names
names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")
set.seed(800)
result <- cmeans(iris[,-5], centers=3, iter.max=100, m=2, method="cmeans")  # 3 clusters
plot(iris[,1], iris[,2], col=result$cluster)
points(result$centers[,c(1,2)], col=1:3, pch=19, cex=2)

result$membership[1:5,] # degree of membership for each observation to each cluster:

table(result$cluster,iris$Species )

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(result)
ptm <- proc.time()
ptm
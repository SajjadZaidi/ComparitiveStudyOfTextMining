
library(rainbow)
library(colorspace) # get nice colors
start_time <- Sys.time()
# Read in `iris` data
# read arff file
diabetes=read.arff(file="D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/-Diabities/diabetes.arff")
iris2 <- diabetes[,-9]
species_labels <- diabetes[,9]


d_iris <- dist(iris2) # method="man" # is a bit better
hc_iris <- hclust(d_iris, method = "complete")
iris_species <- rev(levels(iris[,9]))
str(hc_iris)
clusterCut <- cutree(hc_iris, 2)
table(clusterCut, diabetes$class)
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(clusterCut)
ptm <- proc.time()
ptm


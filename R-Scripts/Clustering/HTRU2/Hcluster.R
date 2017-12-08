#https://cran.r-project.org/web/packages/dendextend/vignettes/Cluster_Analysis.html
#https://www.r-bloggers.com/hierarchical-clustering-in-r-2/

library(rainbow)
library(colorspace) # get nice colors
start_time <- Sys.time()
# Read in `iris` data
HTRU2=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/HTRU2/HTRU_2.arff")

iris2 <- HTRU2[,-9]
species_labels <- HTRU2[,9]


d_iris <- dist(iris2) # method="man" # is a bit better
hc_iris <- hclust(d_iris, method = "complete")
iris_species <- rev(levels(HTRU2[,9]))
str(hc_iris)
clusterCut <- cutree(hc_iris, 2)
table(clusterCut, HTRU2$class)
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(clusterCut)
ptm <- proc.time()
ptm



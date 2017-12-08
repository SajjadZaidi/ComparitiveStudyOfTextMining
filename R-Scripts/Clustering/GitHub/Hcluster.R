
library(rainbow)
library(colorspace) # get nice colors
start_time <- Sys.time()
# Read in `iris` data
git = read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/5-Github/Git.csv", stringsAsFactors=F)
iris2 <- git[,-1]
species_labels <- git[,1]


d_iris <- dist(git[,c(5,7,8)]) # method="man" # is a bit better
hc_iris <- hclust(d_iris, method = "complete")
iris_species <- rev(levels(git[,c(5,7,8)]))
#str(hc_iris)
clusterCut <- cutree(hc_iris, 5)
table(clusterCut, git$Language)
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(hc_iris)
ptm <- proc.time()
ptm
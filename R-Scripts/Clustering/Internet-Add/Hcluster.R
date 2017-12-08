library(rainbow)
library(colorspace) # get nice colors
start_time <- Sys.time()
# Read in `iris` data
set.seed(800)
ad=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/3-InternetAdvertisementDataSets/ad.arff")

ad2 <- ad[,-1559]
species_labels <- ad[,1559]


d_iris <- dist(ad2[,2:3]) # method="man" # is a bit better
hc_iris <- hclust(d_iris, method = "complete")
iris_species <- rev(levels(ad[,1559]))
str(hc_iris)
clusterCut <- cutree(hc_iris, 2)
table(clusterCut, ad$class)
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(clusterCut)
ptm <- proc.time()
ptm

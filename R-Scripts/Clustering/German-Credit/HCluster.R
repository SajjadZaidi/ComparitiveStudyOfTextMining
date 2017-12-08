library(rainbow)
library(colorspace) # get nice colors
#Sort the data
start_time <- Sys.time()
# read arff file
german_credit=read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/german_credit.csv", stringsAsFactors=F);#read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/credit-g.arff")
german_credit$Creditability=as.factor(german_credit$Creditability)

german_credit2 <- german_credit[,-1]
creditability_labels <- german_credit[,1]


d_german_credit <- dist(german_credit2) # method="man" # is a bit better
hc_iris <- hclust(d_german_credit, method = "complete")
iris_species <- rev(levels(german_credit[,1]))

clusterCut <- cutree(hc_iris, 2)
(clusterCut)
table(clusterCut, german_credit$Creditability)
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(clusterCut)
ptm <- proc.time()
ptm
#https://cran.r-project.org/web/packages/dendextend/vignettes/Cluster_Analysis.html
#https://www.r-bloggers.com/hierarchical-clustering-in-r-2/

library(rainbow)
library(colorspace) # get nice colors
start_time <- Sys.time()
# Read in `iris` data
iris <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"), 
                 header = FALSE) 

# Print first lines
head(iris)

# Add column names
names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")
iris2 <- iris[,-5]
species_labels <- iris[,5]


d_iris <- dist(iris2) # method="man" # is a bit better
hc_iris <- hclust(d_iris, method = "complete")
iris_species <- rev(levels(iris[,5]))
str(hc_iris)
clusterCut <- cutree(hc_iris, 3)
table(clusterCut, iris$Species)
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(clusterCut)
ptm <- proc.time()
ptm


library(dendextend)
dend <- as.dendrogram(hc_iris)
# order it the closest we can to the order of the observations:
dend <- rotate(dend, 1:150)

# Color the branches based on the clusters:
dend <- color_branches(dend, k=3) #, groupLabels=iris_species)

# Manually match the labels, as much as possible, to the real classification of the flowers:
labels_colors(dend) <-
  rainbow_hcl(3)[sort_levels_values(
    as.numeric(iris[,5])[order.dendrogram(dend)]
  )]

# We shall add the flower type to the labels:
labels(dend) <- paste(as.character(iris[,5])[order.dendrogram(dend)],
                      "(",labels(dend),")", 
                      sep = "")
# We hang the dendrogram a bit:
dend <- hang.dendrogram(dend,hang_height=0.1)
# reduce the size of the labels:
# dend <- assign_values_to_leaves_nodePar(dend, 0.5, "lab.cex")
dend <- set(dend, "labels_cex", 0.5)
# And plot:
par(mar = c(3,3,3,7))
plot(dend, 
     main = "Clustered Iris data set
     (the labels give the true flower species)", 
     horiz =  TRUE,  nodePar = list(cex = .007))
legend("topleft", legend = iris_species, fill = rainbow_hcl(3))

library(circlize)
# Requires that the circlize package will be installed
par(mar = rep(0,4))
circlize_dendrogram(dend)

some_col_func <- function(n) rev(colorspace::heat_hcl(n, c = c(80, 30), l = c(30, 90), power = c(1/5, 1.5)))

# scaled_iris2 <- iris2 %>% as.matrix %>% scale
 library(gplots)
gplots::heatmap.2(as.matrix(iris2), 
                  main = "Heatmap for the Iris data set",
                  srtCol = 20,
                  dendrogram = "row",
                  Rowv = dend,
                  Colv = "NA", # this to make sure the columns are not ordered
                  trace="none",          
                  margins =c(5,0.1),      
                  key.xlab = "Cm",
                  denscol = "grey",
                  density.info = "density",
                  RowSideColors = rev(labels_colors(dend)), # to add nice colored strips        
                  col = some_col_func
)

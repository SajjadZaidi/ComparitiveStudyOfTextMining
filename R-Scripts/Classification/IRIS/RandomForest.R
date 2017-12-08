#http://www.blopig.com/blog/2017/04/a-very-basic-introduction-to-random-forests-using-r/
#http://rischanlab.github.io/RandomForest.html


#import the package
library(randomForest)
start_time <- Sys.time()
# Read in `iris` data
iris <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"), 
                 header = FALSE) 

# Print first lines
head(iris)

# Add column names
names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

# Set random seed to make results reproducible:
set.seed(800)
# Calculate the size of each of the data sets:
data_set_size <- floor(nrow(iris)/2)

# Generate a random sample of "data_set_size" indexes
indexes <- sample(1:nrow(iris), size = 0.3*nrow(iris))
test <- iris[indexes,]
# Assign the data to the correct sets
training <- iris[-indexes,]


# Perform training:
rf_classifier = randomForest(Species ~ ., data=training, ntree=100, mtry=2, importance=TRUE)
varImpPlot(rf_classifier)

# Validation set assessment #1: looking at confusion matrix
prediction_for_table <- predict(rf_classifier,test[,1:4])
confusionMatrix(prediction_for_table,test[,5])



TotalTime=end_time - start_time
TotalTime
object_size(rf_classifier)
ptm <- proc.time()
ptm
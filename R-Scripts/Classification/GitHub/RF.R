
library(randomForest)

start_time <- Sys.time()
# read arff file
git = read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/5-Github/Git.csv", stringsAsFactors=F)
set.seed(800)
git=git[sample(nrow(git)),]
set.seed(800)
# Set random seed to make results reproducible:

# Calculate the size of each of the data sets:
data_set_size <- floor(nrow(git)/2)

# Generate a random sample of "data_set_size" indexes
indexes <- sample(1:nrow(git), size = 0.3*nrow(git))
# Assign the data to the correct sets
training <- git[-indexes,]
test <- git[indexes,]

# Perform training:
rf_classifier = randomForest(Language ~ ., data=training[c(1,2,4,5,6,7)], ntree=100, mtry=2, importance=TRUE)
varImpPlot(rf_classifier)

# Validation set assessment #1: looking at confusion matrix
prediction_for_table <- predict(rf_classifier,test[,c(2,4,5,6,7)])
confusionMatrix(prediction_for_table,test[,1])
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(rf_classifier)
ptm <- proc.time()
ptm
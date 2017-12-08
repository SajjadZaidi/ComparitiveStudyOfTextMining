
library(randomForest)

# read arff file
diabetes=read.arff(file="D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/-Diabities/diabetes.arff")

# Set random seed to make results reproducible:
set.seed(800)
# Calculate the size of each of the data sets:
data_set_size <- floor(nrow(diabetes)/2)

# Generate a random sample of "data_set_size" indexes
indexes <- sample(1:nrow(diabetes), size = 0.7*nrow(diabetes))
# Assign the data to the correct sets
training <- diabetes[indexes,]
test <- diabetes[-indexes,]

# Perform training:
rf_classifier = randomForest(class ~ ., data=training, ntree=100, mtry=2, importance=TRUE)
varImpPlot(rf_classifier)

# Validation set assessment #1: looking at confusion matrix
prediction_for_table <- predict(rf_classifier,test[,1:8])
confusionMatrix(prediction_for_table,test$class)

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(rf_classifier)
ptm <- proc.time()
ptm
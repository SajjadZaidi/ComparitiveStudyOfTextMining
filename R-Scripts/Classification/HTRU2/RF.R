
library(randomForest)
start_time <- Sys.time()
# read arff file
HTRU2=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/HTRU2/HTRU_2.arff")

# Set random seed to make results reproducible:
set.seed(800)
# Calculate the size of each of the data sets:
data_set_size <- floor(nrow(HTRU2)/2)

# Generate a random sample of "data_set_size" indexes
indexes <- sample(1:nrow(HTRU2), size = 0.7*nrow(HTRU2))
# Assign the data to the correct sets
training <- HTRU2[indexes,]
test <- HTRU2[-indexes,]

# Perform training:
rf_classifier = randomForest(class ~ ., data=training, ntree=100, mtry=2, importance=TRUE)
varImpPlot(rf_classifier)

# Validation set assessment #1: looking at confusion matrix
prediction_for_table <- predict(rf_classifier,test[,1:8])
table(observed=test[,9],predicted=prediction_for_table)
confusionMatrix(prediction_for_table,test[,9])
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(rf_classifier)
ptm <- proc.time()
ptm
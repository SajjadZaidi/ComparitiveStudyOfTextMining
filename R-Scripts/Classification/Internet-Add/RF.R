
library(randomForest)
library(foreign)
start_time <- Sys.time()
#Error empty values i guess
# read arff file

ad=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/3-InternetAdvertisementDataSets/ad.arff")

# Set random seed to make results reproducible:
set.seed(800)
# Calculate the size of each of the data sets:
data_set_size <- floor(nrow(ad)/2)
#ad=as.matrix(ad)
# Generate a random sample of "data_set_size" indexes
indexes <- sample(1:nrow(ad), size = 0.3*nrow(ad))
# Assign the data to the correct sets
training <- ad[-indexes,]
training=training[,c(2,3,1559)]
str(training)
test <- ad[indexes,]
test=test[,c(2,3,1559)]
# Perform training:
rf_classifier = randomForest(class ~ ., data=training, ntree=100, mtry=2, importance=TRUE)
varImpPlot(rf_classifier)

# Validation set assessment #1: looking at confusion matrix
prediction_for_table <- predict(rf_classifier,test[,1:2])
confusionMatrix(prediction_for_table,test[,3])
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
library(pryr)
object_size(rf_classifier)
ptm <- proc.time()
ptm
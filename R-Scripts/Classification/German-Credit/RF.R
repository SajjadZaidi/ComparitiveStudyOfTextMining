
library(randomForest)
start_time <- Sys.time()
# read arff file
german_credit=read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/german_credit.csv", stringsAsFactors=F);#read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/credit-g.arff")
german_credit$Creditability=as.factor(german_credit$Creditability)

set.seed(800)
# Set random seed to make results reproducible:

# Calculate the size of each of the data sets:
data_set_size <- floor(nrow(german_credit)/2)

# Generate a random sample of "data_set_size" indexes
indexes <- sample(1:nrow(german_credit), size = 0.7*nrow(german_credit))
# Assign the data to the correct sets
training <- german_credit[indexes,]
test <- german_credit[-indexes,]

# Perform training:
rf_classifier = randomForest(Creditability ~ ., data=training, ntree=100, mtry=2, importance=TRUE)
varImpPlot(rf_classifier)

# Validation set assessment #1: looking at confusion matrix
prediction_for_table <- predict(rf_classifier,test[,-1])
confusionMatrix(prediction_for_table,test$Creditability)
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(rf_classifier)
ptm <- proc.time()
ptm

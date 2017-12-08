library(foreign)
library(stringr)
library(knitr)
library(caret)
library(ggplot2)
library(lattice)
library(inspectr)

# read arff file
diabetes=read.arff(file="D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/-Diabities/diabetes.arff")
str(diabetes)
set.seed(12345)
#70/30 Sample

indexes = sample(1:nrow(diabetes), size=0.3*nrow(diabetes))

# Split data
test = diabetes[indexes,]
train = diabetes[-indexes,]
y<-train$class
nv=ncol(diabetes)
cm<-list()
str(diabetes)
# Train a model
model_knn <-train(train[,-9],y,'knn',trControl=trainControl(method='cv',number=10))# train(train[, 1:8], train[, 9], method='knn')
(model_knn)

# Predict values
#preds <- predict(model_knn, newdata = test)
predictions<-predict.train(object=model_knn,test[,1:8], type="raw")


# Confusion matrix
confusionMatrix(predictions,test[,9])
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(model_knn)
ptm <- proc.time()
ptm


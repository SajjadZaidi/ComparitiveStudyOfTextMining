library(foreign)
library(stringr)
library(knitr)
library(caret)
library(ggplot2)
library(lattice)
library(inspectr)
start_time <- Sys.time()
# read arff file
ad=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/3-InternetAdvertisementDataSets/ad.arff")
str(ad)
set.seed(800)
#70/30 Sample

indexes = sample(1:nrow(ad), size=0.3*nrow(ad))

# Split data
test = ad[indexes,]
train = ad[-indexes,]
y<-train$class
nv=ncol(ad)
cm<-list()

# Train a model
model_knn <-train(train[,1:2],y,'knn',trControl=trainControl(method='cv',number=10))# train(train[, 1:8], train[, 9], method='knn')
(model_knn)

# Predict values
#preds <- predict(model_knn, newdata = test)
predictions<-predict.train(object=model_knn,test[,1:2], type="raw")


# Confusion matrix
confusionMatrix(predictions,test[,1559])

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(model_knn)
ptm <- proc.time()
ptm

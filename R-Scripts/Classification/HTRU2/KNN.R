library(foreign)
library(stringr)
library(knitr)
library(caret)
library(ggplot2)
library(lattice)
library(inspectr)
start_time <- Sys.time()
# read arff file
HTRU2=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/HTRU2/HTRU_2.arff")
str(HTRU2)
set.seed(800)
#70/30 Sample

indexes = sample(1:nrow(HTRU2), size=0.3*nrow(HTRU2))

# Split data
test = HTRU2[indexes,]
train = HTRU2[-indexes,]
y<-train$class
nv=ncol(diabetes)
cm<-list()

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

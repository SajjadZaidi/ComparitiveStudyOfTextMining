library(foreign)
library(stringr)
library(knitr)
library(caret)
library(ggplot2)
library(lattice)
library(inspectr)

start_time <- Sys.time()
# read arff file
git = read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/5-Github/Git.csv", stringsAsFactors=F)
set.seed(800)
git=git[sample(nrow(git)),]
set.seed(800)
#70/30 Sample

indexes = sample(1:nrow(git), size=0.3*nrow(git))

# Split data
test = git[indexes,]
train = git[-indexes,]
y<-train$Language
nv=ncol(git)
cm<-list()

# Train a model
model_knn <-train(train[,c(2,4,5,6,7,8,9)],y,'knn',trControl=trainControl(method='cv',number=10))# train(train[, 1:8], train[, 9], method='knn')


# Predict values
#preds <- predict(model_knn, newdata = test)
predictions<-predict.train(object=model_knn,test[,c(2,4,5,6,7,8,9)], type="raw")


# Confusion matrix
confusionMatrix(predictions,test$Language)

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(model_knn)
ptm <- proc.time()
ptm

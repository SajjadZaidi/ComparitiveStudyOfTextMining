library(foreign)
library(stringr)
library(knitr)
library(caret)
library(ggplot2)
library(lattice)
library(inspectr)

start_time <- Sys.time()
# read arff file
german_credit=read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/german_credit.csv", stringsAsFactors=F);#read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/credit-g.arff")
german_credit$Creditability=as.factor(german_credit$Creditability)

set.seed(800)
#70/30 Sample

indexes = sample(1:nrow(german_credit), size=0.3*nrow(german_credit))

# Split data
test = german_credit[indexes,]
train = german_credit[-indexes,]
y<-train$Creditability
nv=ncol(german_credit)
cm<-list()
str(diabetes)
# Train a model
model_knn <-train(train[,-1],y,'knn',trControl=trainControl(method='cv',number=10))# train(train[, 1:8], train[, 9], method='knn')
(model_knn)

# Predict values
#preds <- predict(model_knn, newdata = test)
predictions<-predict.train(object=model_knn,test, type="raw")

str(predictions)
# Confusion matrix
confusionMatrix(predictions,test[,1])

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(model_knn)
ptm <- proc.time()
ptm

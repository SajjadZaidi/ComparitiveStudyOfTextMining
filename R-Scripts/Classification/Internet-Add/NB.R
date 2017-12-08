
#Takes too much time
library(stringr)
library(knitr)
library(caret)
library(ggplot2)
library(lattice)
library(foreign)
library(MASS)
# read arff file
start_time <- Sys.time()
ad=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/3-InternetAdvertisementDataSets/ad.arff")


#Sample Indexes
set.seed(800)
#70/30 Sample
indexes = sample(1:nrow(ad), size=0.3*nrow(ad))

# Split data
test = ad[indexes,]
train = ad[-indexes,]
y<-train$class
nv=ncol(HTRU2)
cm<-list()

#head(german_credit)
model = train(train[,1:2],y,'nb',trControl=trainControl(method='cv',number=10))
model
#94% kappa
print(model)
#ConfusionMatrix
preds <- predict(model, newdata = test)#diabetes
table(preds)
confusionMatrix(preds,test[,1559])
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(model)
ptm <- proc.time()
ptm

#New
library(stringr)
library(knitr)
library(caret)
library(ggplot2)
library(lattice)
library(foreign)
start_time <- Sys.time()
# read arff file
diabetes=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/-Diabities/diabetes.arff")

#Sample Indexes
set.seed(800)
#70/30 Sample
indexes = sample(1:nrow(diabetes), size=0.3*nrow(diabetes))

# Split data
test = diabetes[indexes,]
train = diabetes[-indexes,]
y<-train$class


#head(german_credit)
model = train(train[,-9],y,'nb',trControl=trainControl(method='cv',number=10))

#94% kappa
print(model)
#ConfusionMatrix
preds <- predict(model, newdata = test)#diabetes
table(preds)
confusionMatrix(preds,test[,9])

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(model)
ptm <- proc.time()
ptm
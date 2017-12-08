
#New
library(stringr)
library(knitr)
library(caret)
library(ggplot2)
library(lattice)
library(foreign)
library(MASS)
start_time <- Sys.time()
# read arff file
HTRU2=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/HTRU2/HTRU_2.arff")


#Sample Indexes
set.seed(800)
#70/30 Sample
indexes = sample(1:nrow(HTRU2), size=0.3*nrow(HTRU2))

# Split data
test = HTRU2[indexes,]
train = HTRU2[-indexes,]
y<-train$class
nv=ncol(HTRU2)
cm<-list()

#head(german_credit)
#train on only two
model = train(train[,-9],y,'nb',trControl=trainControl(method='cv',number=10))
model
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
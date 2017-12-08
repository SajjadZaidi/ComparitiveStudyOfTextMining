
library(foreign)
library(caret)
library(pryr)
start_time <- Sys.time()
# read arff file
ad=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/3-InternetAdvertisementDataSets/ad.arff")
#Apply on a test data
#70/30 Sample

indexes = sample(1:nrow(ad), size=0.3*nrow(ad))

# Split data
test = ad[indexes,]
train = ad[-indexes,]
train=train[,c(2,3,1559)]
str(train)
test=test[,c(2,3,1559)]
set.seed(800)
control <- trainControl(method="repeatedcv", number=10, repeats=3)
grid <- expand.grid(size=c(5,10,15,20,25,30,35,40,45,50), k=c(1,2))

model <- train(class~., data=as.matrix(train), method="lvq", trControl=control, tuneGrid=grid)

plot(model)

x <- subset(test, select = -class)
# test with train data
pred <- predict(model, test[,1:2])
## (same as:)
#pred <- fitted(model)
summary(pred)

# Confusion matrix
#Does not Work
confusionMatrix(pred,test$class)
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(model)
ptm <- proc.time()
ptm
# Check accuracy:
#t<-table(pred, y)
#print(t)
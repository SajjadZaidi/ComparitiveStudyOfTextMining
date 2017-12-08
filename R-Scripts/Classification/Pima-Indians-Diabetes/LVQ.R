

library(caret)
start_time <- Sys.time()
# read arff file
diabetes=read.arff(file="D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/-Diabities/diabetes.arff")
#Apply on a test data
#70/30 Sample
set.seed(800)
indexes = sample(1:nrow(diabetes), size=0.3*nrow(diabetes))

# Split data
test = diabetes[indexes,]
train = diabetes[-indexes,]

set.seed(7)
control <- trainControl(method="repeatedcv", number=10, repeats=3)
grid <- expand.grid(size=c(5,10,15,20,25,30,35,40,45,50), k=c(3,5))

model <- train(class~., data=train, method="lvq", trControl=control, tuneGrid=grid)
print(model)
plot(model)

x <- subset(test, select = -class)
# test with train data
pred <- predict(model, x)
## (same as:)

summary(pred)

# Confusion matrix
#Does not Work
confusionMatrix(pred,test[,9])

# Check accuracy:
#t<-table(pred, y)
#print(t)
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(model)
ptm <- proc.time()
ptm
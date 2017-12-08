

library(caret)
start_time <- Sys.time()

# read arff file
HTRU2=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/HTRU2/HTRU_2.arff")
#Apply on a test data
#70/30 Sample
set.seed(800)
indexes = sample(1:nrow(HTRU2), size=0.3*nrow(HTRU2))

# Split data
test = HTRU2[indexes,]
train = HTRU2[-indexes,]

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

length(test)

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


library(caret)
start_time <- Sys.time()
# read arff file
german_credit=read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/german_credit.csv", stringsAsFactors=F);#read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/credit-g.arff")
german_credit$Creditability=as.factor(german_credit$Creditability)
#Apply on a test data
#70/30 Sample
set.seed(800)
indexes = sample(1:nrow(german_credit), size=0.3*nrow(german_credit))

# Split data
test = german_credit[indexes,]
train = german_credit[-indexes,]

set.seed(7)
control <- trainControl(method="repeatedcv", number=10, repeats=3)
grid <- expand.grid(size=c(5,10,15,20,25,30,35,40,45,50), k=c(3,5))

model <- train(Creditability~., data=train, method="lvq", trControl=control, tuneGrid=grid)
print(model)
plot(model)

x <- subset(test, select = -Creditability)
# test with train data
pred <- predict(model, x)
## (same as:)

summary(pred)

# Confusion matrix
#Does not Work
confusionMatrix(pred,test[,1])

# Check accuracy:
#t<-table(pred, y)
#print(t)
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(model)
ptm <- proc.time()
ptm
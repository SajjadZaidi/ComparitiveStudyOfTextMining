

library(caret)

start_time <- Sys.time()
# read arff file
git = read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/5-Github/Git.csv", stringsAsFactors=F)
summary(git$Language);
#Apply on a test data
#70/30 Sample
set.seed(800)
git=git[sample(nrow(git)),]
set.seed(800)
indexes = sample(1:nrow(git), size=0.3*nrow(git))

# Split data
test = git[indexes,]
train = git[-indexes,]


control <- trainControl(method="repeatedcv", number=10, repeats=3)
grid <- expand.grid(size=c(5,10,15,20,25,30,35,40,45,50), k=c(2,4,5,6,7,8,9))

model <- train(Language~., data=train[c(1,2,4,5,6,7,8,9)], method="lvq", trControl=control, tuneGrid=grid)
print(model)
plot(model)

x <- subset(test[c(1,2,4,5,6,7,8,9)], select = -Language)
# test with train data
pred <- predict(model, x)
## (same as:)
#pred <- fitted(model)
summary(pred)

# Confusion matrix
#Does not Work
confusionMatrix(pred,test[,1])

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(model)
ptm <- proc.time()
ptm

library(e1071)
start_time <- Sys.time()
# read arff file
HTRU2=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/HTRU2/HTRU_2.arff")
# default with factor response:
#names(diabetes) <- c("preg", "plas", "pres", "skin", "insu","mass","pedi","age","class")
#70/30 Sample
set.seed(800)
indexes = sample(1:nrow(HTRU2), size=0.3*nrow(HTRU2))

# Split data
test = HTRU2[indexes,]
train = HTRU2[-indexes,]

model <- svm(class ~ ., data = train)
#Model Can be changed a little bit


print(model)
summary(model)
x <- subset(test, select = -class)

# test with train data
pred <- predict(model, x)
# (same as:)
pred <- fitted(model)


# compute decision values and probabilities:
pred <- predict(model, x, decision.values = TRUE)
attr(pred, "decision.values")[1:8,]
summary(pred)
# Confusion matrix
confusionMatrix(pred,test[,9])

# visualize (classes by color, SV by crosses):
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(model)
ptm <- proc.time()
ptm
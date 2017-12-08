
library(e1071)
start_time <- Sys.time()
# read arff file
# read arff file
ad=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/3-InternetAdvertisementDataSets/ad.arff")
#names(diabetes) <- c("preg", "plas", "pres", "skin", "insu","mass","pedi","age","class")
#70/30 Sample
set.seed(800)
indexes = sample(1:nrow(ad), size=0.3*nrow(ad))

# Split data
test = ad[indexes,]
train = ad[-indexes,]

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
attr(pred, "decision.values")[1:2,]
summary(pred)
# Confusion matrix
confusionMatrix(pred,test[,1559])

# visualize (classes by color, SV by crosses):
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(model)
ptm <- proc.time()
ptm
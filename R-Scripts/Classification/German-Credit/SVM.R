
library(e1071)
start_time <- Sys.time()
# read arff file
german_credit=read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/german_credit.csv", stringsAsFactors=F);#read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/credit-g.arff")
german_credit$Creditability=as.factor(german_credit$Creditability)

set.seed(800)
indexes = sample(1:nrow(german_credit), size=0.3*nrow(german_credit))

# Split data
test = german_credit[indexes,]
train = german_credit[-indexes,]

model <- svm(Creditability ~ ., data = train)
#Model Can be changed a little bit


print(model)
summary(model)
x <- subset(test, select = -Creditability)

# test with train data
pred <- predict(model, x)
# (same as:)
#pred <- fitted(model)


# compute decision values and probabilities:
#pred <- predict(model, x, decision.values = TRUE)
#attr(pred, "decision.values")[-1,]
#summary(pred)
# Confusion matrix
confusionMatrix(pred,test$Creditability)

# visualize (classes by color, SV by crosses):
#plot(cmdscale(dist(diabetes[,-9])),
#   col = as.diabetes(diabetes[,9]),
#   pch = c("o","+")[1:150 %in% model$index + 1])


end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(model)
ptm <- proc.time()
ptm
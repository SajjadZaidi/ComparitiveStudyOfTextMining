
library(e1071)
library(Matrix)

start_time <- Sys.time()
# read arff file
git = read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/5-Github/Git.csv", stringsAsFactors=F)
set.seed(800)
git=git[sample(nrow(git)),]
set.seed(800)
gitmatrix <- as.matrix(git[complete.cases(git), ])
# default with factor response:
#names(diabetes) <- c("preg", "plas", "pres", "skin", "insu","mass","pedi","age","class")
#70/30 Sample

indexes = sample(1:nrow(gitmatrix), size=0.3*nrow(gitmatrix))

# Split data
test = git[indexes,]
train = git[-indexes,]

model <- svm(Language ~ ., data = train[c(1,2,4,5,6,7,8,9)])
#Model Can be changed a little bit



x <- subset(test[c(1,2,4,5,6,7,8,9)], select = -Language)

# test with train data
pred <- predict(model, x)
# (same as:)



# compute decision values and probabilities:
summary(pred)
# Confusion matrix
confusionMatrix(pred,test$Language)

# visualize (classes by color, SV by crosses):
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(model)
ptm <- proc.time()
ptm
#https://www.r-bloggers.com/using-support-vector-machines-as-flower-finders-name-that-iris/
library(e1071)
start_time <- Sys.time()
# Read in `iris` data
iris <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"), 
                 header = FALSE) 

# Print first lines
head(iris)

# Add column names
names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")



set.seed(800)
indexes = sample(1:nrow(iris), size=0.3*nrow(iris))

# Split data
test = iris[indexes,]
train = iris[-indexes,]

model <- svm(Species ~ ., data = train)
#Model Can be changed a little bit



x <- subset(test, select = -Species)

# test with train data
#pred <- predict(model, x)
# (same as:)
#pred <- fitted(model)


# compute decision values and probabilities:
pred <- predict(model, x, decision.values = TRUE)
attr(pred, "decision.values")[1:4,]
summary(pred)
# Confusion matrix
confusionMatrix(pred,test[,5])

TotalTime=end_time - start_time
TotalTime
object_size(model)
ptm <- proc.time()
ptm
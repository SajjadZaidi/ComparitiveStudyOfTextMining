#http://trymachinelearning.com/machine-learning-algorithms/instance-based/learning-vector-quantization/
library(caret)
start_time <- Sys.time()
# Read in `iris` data
iris <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"), 
                 header = FALSE) 

# Print first lines
head(iris)

# Add column names
names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

#-----
set.seed(800)
indexes = sample(1:nrow(iris), size=0.3*nrow(iris))

# Split data
test = iris[indexes,]
train = iris[-indexes,]


control <- trainControl(method="repeatedcv", number=10, repeats=3)
grid <- expand.grid(size=c(5,10,15,20,25,30,35,40,45,50), k=c(3,5))

model <- train(Species~., data=train, method="lvq", trControl=control, tuneGrid=grid)

plot(model)

x <- subset(test, select = -Species)
# test with train data
pred <- predict(model, x)
## (same as:)
#pred <- fitted(model)
#summary(pred)

# Confusion matrix
#Does not Work
confusionMatrix(pred,test[,5])

TotalTime=end_time - start_time
TotalTime
object_size(model)
ptm <- proc.time()
ptm
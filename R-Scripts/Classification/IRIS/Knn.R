library(farff)
library(foreign)
library(naivebayes)
library(Formula)
library(magrittr)
library(ggvis)
library(class)
library(gmodels)
library(caret)
start_time <- Sys.time()
# Read in `iris` data
iris <- read.csv(url("http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"), 
                 header = FALSE) 

# Print first lines
head(iris)

# Add column names
names(iris) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

# Check the result
#iris

iris %>% ggvis(~Petal.Length, ~Petal.Width, fill = ~Species) %>% layer_points()

# Overall correlation `Petal.Length` and `Petal.Width`
cor(iris$Petal.Length, iris$Petal.Width)

# Return values of `iris` levels 
x=levels(iris$Species)

# Print Setosa correlation matrix
print(x[1])
cor(iris[iris$Species==x[1],1:4])

# Print Versicolor correlation matrix
print(x[2])
cor(iris[iris$Species==x[2],1:4])

# Print Virginica correlation matrix
print(x[3])
cor(iris[iris$Species==x[3],1:4])

# Create index to split based on labels  
#index <- createDataPartition(iris$Species, p=0.75, list=FALSE)


#----------------------------------
set.seed(800)
#70/30 Sample

indexes = sample(1:nrow(iris), size=0.3*nrow(iris))

# Split data
test = iris[indexes,]
train = iris[-indexes,]
y<-train$Species
nv=ncol(iris)
cm<-list()
str(iris)
# Train a model
model_knn <-train(train[,-5],y,'knn',trControl=trainControl(method='cv',number=10))# train(train[, 1:8], train[, 9], method='knn')
(model_knn)

# Predict values
#preds <- predict(model_knn, newdata = test)
predictions<-predict.train(object=model_knn,test[,1:4], type="raw")


# Confusion matrix
confusionMatrix(predictions,test$Species)



TotalTime=end_time - start_time
TotalTime
object_size(gitCluster)
ptm <- proc.time()
ptm
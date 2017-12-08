library(farff)
library(foreign)
library(naivebayes)
library(Formula)
library(magrittr)
library(ggvis)
library(class)
library(gmodels)
library(caret)
library(e1071)
library(pryr)
# read arff file
start_time <- Sys.time()
iris_data=read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/FinalSelected/2-IRIS/iris.arff")

#Plot
iris_data %>% ggvis(~petallength, ~petalwidth, fill = ~class) %>% layer_points()
set.seed(800)
#70/30 Sample
indexes = sample(1:nrow(iris_data), size=0.3*nrow(iris_data))

# Split data
test = iris_data[indexes,]
train = iris_data[-indexes,]
y<-train$class
nv=ncol(iris_data)
cm<-list()

#head(german_credit)
model = train(train[,-5],y,'nb',trControl=trainControl(method='cv',number=10))
model
#94% kappa
print(model)
#ConfusionMatrix
preds <- predict(model, newdata = test)#diabetes
table(preds)
confusionMatrix(preds,test[,5])

# Old Method
#model <- naive_bayes(class ~ ., data = iris_data)
#print(model)
#predict(model, irispet)
TotalTime=end_time - start_time
TotalTime
object_size(model)
ptm <- proc.time()
ptm



#New
library(stringr)
library(knitr)
library(caret)
library(ggplot2)
library(lattice)
library(foreign)
library(MASS)

start_time <- Sys.time()
# read arff file
git = read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/5-Github/Git.csv", stringsAsFactors=F)
set.seed(800)
git=git[sample(nrow(git)),]
help("sample")
summary(git)
#Sample Indexes

#70/30 Sample
indexes = sample(1:nrow(git), size=0.3*nrow(git))

# Split data
test = git[indexes,]
train = git[-indexes,]
y<-train$Language
nv=ncol(git)
cm<-list()

#head(german_credit)
model = train(train[,c(2,4,5,6,7,8,9)],y,'nb',trControl=trainControl(method='cv',number=10))
#model

#ConfusionMatrix
preds <- predict(model, newdata = test)#diabetes
table(preds,test$Language)
str(preds)
confusionMatrix(preds,test$Language)
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(model)
ptm <- proc.time()
ptm
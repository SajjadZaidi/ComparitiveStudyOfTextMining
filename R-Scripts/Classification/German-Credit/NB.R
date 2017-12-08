
#New
library(stringr)
library(knitr)
library(caret)
library(ggplot2)
library(lattice)
library(foreign)
#There are a bunch of NAN values filter them out.
start_time <- Sys.time()
# read arff file
german_credit=read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/german_credit.csv", stringsAsFactors=F);#read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/2-GermanCredit/credit-g.arff")
german_credit$Creditability=as.factor(german_credit$Creditability)
str(german_credit)
#Sample Indexes
set.seed(800)
#70/30 Sample
indexes = sample(1:nrow(german_credit), size=0.3*nrow(german_credit))

# Split data
test = german_credit[indexes,]
train = german_credit[-indexes,]
y<-(train$Creditability)


#head(german_credit)
model = train(train[,-1],y,'nb',trControl=trainControl(method='cv',number=10))

#94% kappa
print(model)
#ConfusionMatrix
preds <- predict(model, newdata = test)#diabetes
table(preds)
confusionMatrix(preds,test$Creditability)

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(model)
ptm <- proc.time()
ptm

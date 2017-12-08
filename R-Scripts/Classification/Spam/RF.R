library(foreign)
library(tm)
library(wordcloud)
library(e1071)
library(caret)
library(SnowballC)
library(RTextTools)

# read arff file
#sms =read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/4-Spam/SMSSpamCollection.arff")
sms = read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/4-Spam/sms_spam.csv", stringsAsFactors=F)
set.seed(2012)
train.data=sms[1:3902, ] 
test.data=sms[3903:5574, ]
train_out.data <- train.data$type
train_txt.data <- train.data$text
train.num   <- nrow(train.data)
#Build Corpus
sms_corpus = Corpus(VectorSource(sms$text))
#print(sms_corpus)

#inspect(sms_corpus[1:3])

#We need to clean up the data for the aforementioned fluff, we'll use tm_map()
corpus_clean = tm_map(sms_corpus, tolower)                    # convert to lower case
corpus_clean = tm_map(corpus_clean, removeNumbers)            # remove digits
corpus_clean = tm_map(corpus_clean, removeWords, stopwords()) # and but or you etc
corpus_clean = tm_map(corpus_clean, removePunctuation)        # you'll never guess!
corpus_clean = tm_map(corpus_clean, stripWhitespace)          # reduces w/s to 1
inspect(corpus_clean[1:3])

#corpus_clean = tm_map(corpus_clean, PlainTextDocument, mc.cores = 1) # this is a tm API necessity
dtm = DocumentTermMatrix(corpus_clean)


matrix <- create_matrix(train_txt.data, language='english', minWordLength=3, removeNumbers=TRUE, stemWords=FALSE, removePunctuation=TRUE, weighting=weightTfIdf)
str(matrix)
str(train_out.data)
#help(create_container)
container <- create_container(dtm,train_out.data, trainSize=1:3902, testSize=3903:5574, virgin=FALSE)
#maxent.model    <- train_model(container, 'MAXENT')
RF.model       <- train_model(container, 'RF')#Takes time
help(train_model)
RF.result    <- classify_model(container, RF.model)
#rownames(svm.result) <- make.names(svm.result[,1], unique = TRUE)

#svm.analytic  <- create_analytics(container, svm.result)
str(RF.result)
table(RF.result$FORESTS_LABEL,test.data$type)

TotalTime=end_time - start_time
TotalTime
library(pryr)
object_size(RF.model)
ptm <- proc.time()
ptm
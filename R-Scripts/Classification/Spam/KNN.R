library(foreign)
#library(tm)
library(SnowballC) 
library(class)
library(caret)
library(quanteda)
#need to make it work
#https://rpubs.com/mzc/mlwr_nb_sms_spam
# read arff file
#sms =read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/4-Spam/SMSSpamCollection.arff")
sms = read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/4-Spam/sms_spam.csv", stringsAsFactors=F)


round(prop.table(table(sms$type))*100, digits = 1)
sms$type = factor(sms$type)

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



# split the raw data:
sms.train = sms[1:3902, ] # about 75%
sms.test  = sms[3903:5574, ] # the rest

# then split the document-term matrix
dtm.train = dtm[1:3902, ]
dtm.test  = dtm[3903:5574, ]

# and finally the corpus
corpus.train = corpus_clean[1:3902]
corpus.test  = corpus_clean[3903:5574]

spam = subset(sms.train, type == "spam")
ham  = subset(sms.train, type == "ham")

freq_terms = findFreqTerms(dtm.train, 5)
reduced_dtm.train = DocumentTermMatrix(corpus.train, list(dictionary=freq_terms))
reduced_dtm.test =  DocumentTermMatrix(corpus.test, list(dictionary=freq_terms))
#ncol(reduced_dtm.train)

convert_counts = function(x) {
  x = ifelse(x > 0, 1, 0)
  x = factor(x, levels = c(0, 1), labels=c("ham", "spam"))
  return (x)
}

# apply() allows us to work either with rows or columns of a matrix.
# MARGIN = 1 is for rows, and 2 for columns
reduced_dtm.train = apply(reduced_dtm.train, MARGIN=2, convert_counts)
reduced_dtm.test  = apply(reduced_dtm.test, MARGIN=2, convert_counts)

sms_train_labels <- sms[1:3902,]$type
sms_test_labels <- sms[3903:5574,]$type
# Train a model
model_knn <- train(reduced_dtm.train, sms_train_labels, method='knn')

#knn.pred <- knn(dtm.train, dtm.test , sms_train_labels)
# Predict values
#predictions<-predict.train(object=model_knn,reduced_dtm.test, type="raw")
predictions=predict(model_knn,
        reduced_dtm.test)

# Confusion matrix
confusionMatrix(predictions,sms$type)

TotalTime=end_time - start_time
TotalTime
object_size(model)
ptm <- proc.time()
ptm
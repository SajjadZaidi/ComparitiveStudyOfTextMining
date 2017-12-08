library(foreign)
library(tm)
library(wordcloud)
library(e1071)
library(caret)
library(SnowballC)
start_time <- Sys.time()
#https://rpubs.com/mzc/mlwr_nb_sms_spam
# read arff file
#sms =read.arff(file= "D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/4-Spam/SMSSpamCollection.arff")
sms = read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/4-Spam/sms_spam.csv", stringsAsFactors=F)


str(sms)
round(prop.table(table(sms$type))*100, digits = 1)
sms$type = factor(sms$type)

#Build Corpus
sms_corpus = Corpus(VectorSource(sms$text))
print(sms_corpus)

inspect(sms_corpus[1:3])

#We need to clean up the data for the aforementioned fluff, we'll use tm_map()
corpus_clean = tm_map(sms_corpus, tolower)                    # convert to lower case
corpus_clean = tm_map(corpus_clean, removeNumbers)            # remove digits
corpus_clean = tm_map(corpus_clean, removeWords, stopwords()) # and but or you etc
corpus_clean = tm_map(corpus_clean, removePunctuation)        # you'll never guess!
corpus_clean = tm_map(corpus_clean, stripWhitespace)          # reduces w/s to 1
inspect(corpus_clean[1:3])

#corpus_clean = tm_map(corpus_clean, PlainTextDocument, mc.cores = 1) # this is a tm API necessity
dtm = DocumentTermMatrix(corpus_clean)
str(dtm)


# split the raw data:
sms.train = sms[1:3902, ] # about 75%
sms.test  = sms[3903:5574, ] # the rest

# then split the document-term matrix
dtm.train = dtm[1:3902, ]
dtm.test  = dtm[3903:5574, ]

# and finally the corpus
corpus.train = corpus_clean[1:3902]
corpus.test  = corpus_clean[3903:5574]

# let's just assert that our split is reasonable: raw data should have about 87% ham
# in both training and test sets:
round(prop.table(table(sms.train$type))*100)

wordcloud(corpus.train,
          min.freq=40,          # 10% of num docs in corpus is rough standard
          random.order = FALSE) # biggest words are nearer the centre

spam = subset(sms.train, type == "spam")
ham  = subset(sms.train, type == "ham")

wordcloud(spam$text,
          max.words=40,     # look at the 40 most common words
          scale=c(3, 0, 5)) # adjust max and min font sizes for words shown


wordcloud(ham$text,
          max.words=40,     # look at the 40 most common words
          scale=c(3, 0, 5)) # adjust max and min font sizes for words shown

#So looks like the biggest words don't overlap much between ham and spam - this suggests NB has a fighting chance.

freq_terms = findFreqTerms(dtm.train, 5)
reduced_dtm.train = DocumentTermMatrix(corpus.train, list(dictionary=freq_terms))
reduced_dtm.test =  DocumentTermMatrix(corpus.test, list(dictionary=freq_terms))

# have we reduced the number of features?
ncol(reduced_dtm.train)

convert_counts = function(x) {
  x = ifelse(x > 0, 1, 0)
  x = factor(x, levels = c(0, 1), labels=c("No", "Yes"))
  return (x)
}

# apply() allows us to work either with rows or columns of a matrix.
# MARGIN = 1 is for rows, and 2 for columns
reduced_dtm.train = apply(reduced_dtm.train, MARGIN=2, convert_counts)
reduced_dtm.test  = apply(reduced_dtm.test, MARGIN=2, convert_counts)

# store our model in sms_classifier
sms_classifier = naiveBayes(reduced_dtm.train, sms.train$type)
sms_test.predicted = predict(sms_classifier,
                             reduced_dtm.test)


library(gmodels)
CrossTable(sms_test.predicted,
           sms.test$type,
           prop.chisq = FALSE, # as before
           prop.t     = FALSE, # eliminate cell proprtions
           dnn        = c("predicted", "actual")) # relabels rows+cols
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(model)
ptm <- proc.time()
ptm

library(ggplot2)
library(functional)
library(caret)
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
#str(sms)
#m <- list(ID = "type", Content = "text")
#myReader <- readTabular(mapping = m)
#sms_corpus <- Corpus(DataframeSource(sms), readerControl = list(reader = myReader))
#summary(sms_corpus)
# Manually keep ID information from https://stackoverflow.com/a/14852502/1036500
#for (i in 1:length(sms_corpus)) {
#  attr(sms_corpus[[i]], "type") <- sms$type[i]
#}

set.seed(800)

#Build Corpus

myReader <- readTabular(mapping=list(id="type", content="text"))
sms_corpus <- VCorpus(DataframeSource(sms), readerControl=list(reader=myReader))

#sms_corpus = Corpus(VectorSource(sms$text))#,
                    #readerControl = list(reader=myReader))
#for (i in 1:length(sms_corpus)) {
#  attr(sms_corpus[[i]], "type") <- sms$type[i]
#
#lapply(sms_corpus, as.character)

#sms_corpus[,"type"]=sms$type

#print(sms_corpus)
#summary(sms_corpus)
#inspect(sms_corpus[1:3])

#We need to clean up the data for the aforementioned fluff, we'll use tm_map()
corpus_clean = tm_map(sms_corpus, content_transformer(tolower))                    # convert to lower case
corpus_clean = tm_map(corpus_clean, content_transformer(removeNumbers))            # remove digits
corpus_clean = tm_map(corpus_clean, content_transformer(removeWords), stopwords()) # and but or you etc
corpus_clean = tm_map(corpus_clean, content_transformer(removePunctuation)  )      # you'll never guess!
corpus_clean = tm_map(corpus_clean, content_transformer(stripWhitespace)  )        # reduces w/s to 1

#corpus_clean = tm_map(corpus_clean, PlainTextDocument, mc.cores = 1) # this is a tm API necessity
dtm = DocumentTermMatrix(corpus_clean)


rowTotals <- apply(dtm , 1, sum) #Find the sum of words in each Document

dtm  <- dtm[rowTotals> 0, ]           #remove all docs without words
removeSparseTerms(dtm, .50)
dtm[apply(dtm, 1, Compose(is.finite, all)),]

findFreqTerms(dtm, 100)
## do tfxidf
dtm_tfxidf <- weightTfIdf(dtm)

rowTotals <- apply(dtm_tfxidf , 1, sum) #Find the sum of words in each Document
rowTotals
dtm_tfxidf  <- dtm_tfxidf[rowTotals> 0, ]           #remove all docs without words


#inspect(dtm_tfxidf[1:10, 5001:5010])


## do document clustering

### k-means (this uses euclidean distance)
m <- as.matrix(dtm_tfxidf)
rownames(m) <- 1:nrow(m)

### don't forget to normalize the vectors so Euclidean makes sense
norm_eucl <- function(m) m/apply(m, MARGIN=1, FUN=function(x) sum(x^2)^.5)
m_norm <- norm_eucl(m)
str(attr(dtm_tfxidf[1,],"weighting"))

#matrix <- create_matrix(train_txt.data, language='english', minWordLength=3, removeNumbers=TRUE, stemWords=FALSE, removePunctuation=TRUE, weighting=weightTfIdf)
#str(matrix)
#str(train_out.data)
#help(create_container)
#container <- create_container(dtm,train_out.data, trainSize=1:4200, testSize=4201:5574, virgin=FALSE)

set.seed(800)
Cluster <- kmeans(dtm_tfxidf, 2, nstart = 20)
str(Cluster$cluster)
#K-means clustering with 3 clusters of sizes 46, 54, 50
table(Cluster$cluster, dtm_tfxidf$dimnames$Docs)
end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(Cluster)
ptm <- proc.time()
ptm
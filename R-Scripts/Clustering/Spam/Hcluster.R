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
library(rainbow)
library(colorspace) # get nice colors
start_time <- Sys.time()
# read arff file
sms = read.csv("D:/Masters/Sem2/671/Project/DataSetAndStudy/DataSetsForStudy/4-Spam/sms_spam.csv", stringsAsFactors=F)
#Clusters can be improved and Different column can be used
#Find Better Factors
set.seed(800)

#Build Corpus

myReader <- readTabular(mapping=list(id="type", content="text"))
sms_corpus <- VCorpus(DataframeSource(sms), readerControl=list(reader=myReader))
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

rowTotals <- apply(as.mdtm_tfxidf , 1, sum) #Find the sum of words in each Document
rowTotals
dtm_tfxidf  <- dtm_tfxidf[rowTotals> 0, ]           #remove all docs without words





d_iris <- dist(dtm_tfxidf) # method="man" # is a bit better
hc_iris <- hclust(dtm_tfxidf, method = "complete")
iris_species <- rev(levels(sms[,1]))
str(hc_iris)
Cluster <- cutree(hc_iris, 2)
str(dtm_tfxidf$dimnames$Docs)
table(Cluster, dtm_tfxidf$dimnames$Docs)

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(Cluster)
ptm <- proc.time()
ptm

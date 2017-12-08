
library(gmodels)
library(caret)
library(ggplot2)
library(kernlab)
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


set.seed(800)
Cluster <- kkmeans(as.matrix(dtm_tfxidf), centers=2)#kkmeans(iris[, 3:4], 3, nstart = 20)
str(Cluster)
#K-means clustering with 3 clusters of sizes 46, 54, 50
table(Cluster, dtm_tfxidf$dimnames$Docs)

#Plotting Clusters Issue with the clusters
diabetesClustera<- as.factor(diabetesCluster)
ggplot(diabetes, aes(insu, pedi, color = diabetesClustera)) + geom_point()

end_time <- Sys.time()

TotalTime=end_time - start_time
TotalTime
object_size(Cluster)
ptm <- proc.time()
ptm
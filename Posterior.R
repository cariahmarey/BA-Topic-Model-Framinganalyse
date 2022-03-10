# posterior distributions
set.seed(100)

# posterior distributions
# theta over K topics within each document
# beta over V terms within each topic (V: length of vocab)
tmResult <- posterior(lda_model)
theta <- tmResult$topics
beta <- tmResult$terms

# create dataframes of posterior distributions
theta_df <- data.frame(theta)
beta_df <- data.frame(beta)

# plot theta for every frame
theta_plot <- plot.ts(theta_df)

plot.ts(theta_df$X1, xy.labels = T)

# calculate and plot mean 
theta_means <- colMeans(theta_df)
hist(theta_means)
plot.ts(theta_means)

####################
# Topic ranking
# re-rank top terms for topic names
topicNames <- apply(lda::top.topic.words(beta, 5, by.score = T), 2, paste, collapse = " ")

# most probable topics in the collection (score over 0.1:
# not really a background topic
topicProportions <- colSums(theta) / nrow(DTM)
sort(topicProportions, decreasing = T)

# Rank-1
# topic 1 has second highest rank
# 133  84 129 155 101 130  91 106  98 101
countsOfPrimaryTopics <- rep(0, K)
for (i in i:nrow(DTM)) {
  # select topic distribution for document i
  topicsPerDoc <- theta[i, ]
  # get first element position from ordered list
  primaryTopic <- order(topicsPerDoc, decreasing = T)[1]
  countsOfPrimaryTopics[primaryTopic] <- countsOfPrimaryTopics[primaryTopic] +1
}
countsOfPrimaryTopics

# filtering documents
topicToFilter <- 1
topicThreshold <- 0.9
selectedDocumentIndexes <- (theta[, topicToFilter] >= topicThreshold)
filteredCorpus <- textdata_corpus %>% corpus_subset(subset = selectedDocumentIndexes)

filteredCorpus


# LDAvis
svd_tsne <- function(x) tsne(svd(x)$u)
json <- createJSON(
  phi = tmResult$terms,
  theta = tmResult$topics,
  doc.length = rowSums(DTM),
  vocab = colnames(DTM),
  term.frequency = colSums(DTM),
  mds.method = svd_tsne,
  plot.opts = list(xlab="", ylab="")
)
serVis(json)



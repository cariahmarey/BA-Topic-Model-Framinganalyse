# Rank-1
countsOfPrimaryTopics <- rep(0, K)
for (i in i:nrow(DTM)) {
  # select topic distribution for document i
  topicsPerDoc <- theta[i, ]
  # get first element position from ordered list
  primaryTopic <- order(topicsPerDoc, decreasing = T)[1]
  countsOfPrimaryTopics[primaryTopic] <- countsOfPrimaryTopics[primaryTopic] +1
}
countsOfPrimaryTopics

# topic diagnostics
topic_diagnostics <- topic_diagnostics(lda_model, DTM, top_n_tokens = 20)

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



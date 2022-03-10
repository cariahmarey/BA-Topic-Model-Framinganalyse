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

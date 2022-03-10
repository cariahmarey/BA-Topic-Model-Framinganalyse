# Intrusion Detection
# import word intrusion function
# import topic intrusion function

# test word intrusion
tm_word_intrusion(beta = beta_df)

# test topic intrusion
tm_topic_intrusion(beta = beta_df, theta = theta, corpus = textdata_corpus)
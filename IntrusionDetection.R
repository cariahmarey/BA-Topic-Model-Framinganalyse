# Intrusion Detection
# import and run word intrusion function
# import and run topic intrusion function

# test word intrusion
tm_word_intrusion(beta = beta_df)

# test topic intrusion
tm_topic_intrusion(beta = beta_df, theta = theta, corpus = textdata_corpus)

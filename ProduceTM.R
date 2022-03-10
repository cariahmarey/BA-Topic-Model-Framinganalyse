# create topic models for α = 0.01 and K = 7,8,9
controls = list(seed = 100, alpha = 0.01, burnin = 300)
for(i in 7:9) { 
  
  # set number of topics
  K <- i
  # compute LDA model
  lda_model <- LDA(DTM, 
                   K, 
                   method = "Gibbs", 
                   control = controls,
                   verbose = T)
  
  topics <- terms(lda_model, 20)
  
  #create xlsx docs
  path_tm <- paste0("<filepath>",i,"<restoffilepath>.xlsx")
  write.xlsx(topics, path_tm, row.names = F)
}


# create topic models for α = 0.02 and K = 8,9,10,11
controls = list(seed = 100, alpha = 0.02, burnin = 300)
for(i in 8:11) { 
  
  # set number of topics
  K <- i
  # compute LDA model
  lda_model <- LDA(DTM, 
                   K, 
                   method = "Gibbs", 
                   control = controls,
                   verbose = T)
  
  topics <- terms(lda_model, 20)
  
  #create xlsx docs
  path_tm <- paste0("<filepath>",i,"<restoffilepath>.xlsx")
  write.xlsx(topics, path_tm, row.names = F)
}


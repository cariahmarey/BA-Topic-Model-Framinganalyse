# create topic models for α = 0.01 and K = 7,8,9
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
  path_tm <- paste0("C:/Users/mariu/OneDrive/Dokumente/Studium Leipzig/Wintersemester 21-22/Bachelorarbeit/Topic Model Test in RStudio/Topic Model Test Final BA/tm_k",i,"_a001.xlsx")
  write.xlsx(topics, path_tm, row.names = F)
}


# create topic models for α = 0.02 and K = 10,
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
  path_tm <- paste0("C:/Users/mariu/OneDrive/Dokumente/Studium Leipzig/Wintersemester 21-22/Bachelorarbeit/Topic Model Test in RStudio/Topic Model Test Final BA/tm_k",i,"_a002.xlsx")
  write.xlsx(topics, path_tm, row.names = F)
}


save(topics_df, file = "topterms.Rda")
topics_df <- data.frame(topics)

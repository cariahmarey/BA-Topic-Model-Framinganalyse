# create lists with possible synonyms
# cm = cultural motive
cm1_syns <- synonyms(c("profit", "political", "advertisement", "communication"))
cm2_syns <- synonyms(c("survey", "society", "recognize","pattern"))
cm3_syns <- synonyms(c("secret", "surveillance", "track"))
cm4_syns <- synonyms(c("crime", "prevention"))
cm5_syns <- synonyms(c("social", "empower", "citizen", "participation"))
cm6_syns <- synonyms(c("knowledge", "power"))
cm7_syns <- synonyms(c("social", "development"))
cm8_syns <- synonyms(c("increase", "efficiency", "intelligence"))

# create keyword lists with matching synonyms
cm1_syns_narrow <- do.call(c, list("profit", "political", "advertisement", "communication",
                                      cm1_syns$profit.def_4, cm1_syns$profit.def_6, 
                                      cm1_syns$political.def_1, cm1_syns$advertisement.def_1,
                                      cm1_syns$advertisement.def_2, cm1_syns$advertisement.def_3,
                                      cm1_syns$communication.def_1, cm1_syns$communication.def_2))

cm2_syns_narrow <- do.call(c, list("survey", "society", "recognize","pattern", 
                                      cm2_syns$survey.def_1, cm2_syns$society.def_1,
                                      cm2_syns$recognize.def_1, cm2_syns$pattern.def_2))

cm3_syns_narrow <- do.call(c, list("secret", "surveillance", "track", 
                                      cm3_syns$secret.def_7, cm3_syns$surveillance.def_1,
                                      cm3_syns$track.def_4, cm3_syns$track.def_6))

cm4_syns_narrow <- do.call(c, list("crime", "prevention","prosecution",
                                      cm4_syns$crime.def_1, cm4_syns$crime.def_2,
                                      cm4_syns$crime.def_3, cm4_syns$prevention.def_1))

cm5_syns_narrow <- do.call(c, list("social", "empower", "citizen", "participation", 
                                      cm5_syns$social.def_1, cm5_syns$empower.def_1,
                                      cm5_syns$participation.def_1))

cm6_syns_narrow <- do.call(c, list("knowledge", "power",
                                      cm6_syns$knowledge.def_1, cm6_syns$power.def_2,
                                      cm6_syns$power.def_3))

cm7_syns_narrow <- do.call(c, list("social", "development", 
                                      cm7_syns$social.def_1, cm7_syns$development.def_1))

cm8_syns_narrow <- do.call(c, list("increase", "efficiency", "intelligence", 
                                      cm8_syns$increase.def_1, cm8_syns$efficiency.def_1,
                                      cm8_syns$intelligence.def_2, cm8_syns$intelligence.def_7))

cm_syns_narrow = list(cm1_syns_narrow, cm2_syns_narrow, cm3_syns_narrow, cm4_syns_narrow, cm5_syns_narrow, cm6_syns_narrow, cm7_syns_narrow, cm8_syns_narrow)


# calculate number of tokens of synonym list (372 tokens)
cm_syns_narrow <- list(cm1_syns_narrow, cm2_syns_narrow, cm3_syns_narrow, cm4_syns_narrow, cm5_syns_narrow, cm6_syns_narrow, cm7_syns_narrow, cm8_syns_narrow)
cm_syns_narrow_tokens_sum <- sum(ntoken(unlist(cm_syns_narrow)))

# remove duplicated rows
cm_syns_narrow_df <- data.frame(unlist(cm_syns_narrow))
cm_syns_narrow_df <- cm_syns_narrow_df[!duplicated(cm_syns_narrow_df), ]

# lemmatization and removing of stopwords
cm_syns_tokens <- tokens(cm_syns_narrow_df)
cm_syns_tokens <- cm_syns_tokens %>%
  tokens_replace(lemma_data$inflected_form, lemma_data$lemma, valuetype = "fixed") %>%
  tokens_remove(pattern = stopword_data, padding = T)

# remove empty rows of synonyms dataframe and calculate final number of tokens (301 tokens)
cm_syns <- data.frame(unlist(cm_syns_tokens))
cm_syns <- cm_syns[!apply(cm_syns == "", 1, all), ]
cm_syns_tokens_sum <- sum(ntoken(cm_syns))

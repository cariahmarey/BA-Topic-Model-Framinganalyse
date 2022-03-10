# Implementation of https://www.umiacs.umd.edu/~jbg/docs/nips2009-rtl.pdf
tm_topic_intrusion <- function(beta, theta, corpus, runs = 10, setsize = 4, document = "random", chance_correction = T) {

  require(htmltools)

  readIntruder <- function()
  {
    n <- readline(prompt="Intruder: ")
    if (n == "") {
      cat("Correct selections: ", correct_selections, " out of ", (iter - 1), "\n")
      stop("Aborted")
    }
    n <- as.integer(n)
    if (is.na(n)){
      n <- readIntruder()
    }
    if (n < 1 | n > setsize){
      n <- readIntruder()
    }
    return(n)
  }

  correct_selections <- 0
  K <- nrow(beta)
  nDocs <- nrow(theta)

  # select a document
  if (document == "random") {
    docs <- sample(1:nDocs, runs)
  } else {
    docs <- rep(document, runs)
  }

  # create topic names
  topic_names <- apply(beta, 1, FUN = function(x) {
    paste(names(sort(x, decreasing = T)[1:5]), collapse = " ")
  })

  viewer <- getOption("viewer")

  for (iter in 1:runs) {

    d <- docs[iter]

    cat("Topic intrusion", iter, "of", runs, "\n")

    # show document in viewer pane
    if (!is.null(viewer)) {
      doc_html <- as.character(corpus[[d]])
      doc_html <- gsub("\n", "<br/>", doc_html)
      html_print(HTML(paste0("<h2>Document ", d, "</h2><p>", doc_html, "<p>")))
    } else {
      cat(as.character(corpus[[d]]), "\n")
    }

    # select setsize - 1 most probable topic
    top_topics <- order(theta[d, ], decreasing = T)
    top_topic_names <- topic_names[top_topics[1:(setsize-1)]]
    intruder_topic <- sample(top_topics[ceiling((K+1)/2):K], 1)
    intruder_topic_name <- topic_names[intruder_topic]


    eval_list <- sample(c(top_topic_names, intruder_topic_name))
    intruder_true_position <- which(eval_list == intruder_topic_name)

    for (i in 1:setsize) cat("[", i, "] ", eval_list[i], "\n")

    intruder_user_selection <- readIntruder()

    if (intruder_true_position == intruder_user_selection) {
      cat("CORRECT SELECTION\n")
      correct_selections <- correct_selections + 1
    } else {
      cat("FALSE SELECTION\n")
    }

  }

  performance <- correct_selections / runs

  if (chance_correction) {
    random_probabilty <- 1 / setsize
    performance <- (performance - random_probabilty) / (1 - random_probabilty)
  }

  cat("Performance:", performance, " (", correct_selections, " out of ", runs, ")\n")

  return(performance)
}

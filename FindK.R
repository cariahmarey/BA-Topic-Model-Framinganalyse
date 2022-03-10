# find values for K and α
# set seed, α and burnin
controls = list(seed = 100, alpha = 0.02, burnin = 300)

result <- FindTopicsNumber(
  DTM,
  topics = seq(from = 5, to = 30, by = 1),
  metrics = c("Deveaud2014"),
  method = "Gibbs",
  control = controls,
  verbose = T
)

findk_plot <- FindTopicsNumber_plot(result)



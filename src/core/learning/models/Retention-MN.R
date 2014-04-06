# Christopher L. Simons, 2013

model <- list()

d <- read.csv("data/Retention-MN-10K.csv", header = TRUE)
d <- data.frame(intervalScale(as.matrix(d)))

g <- graphNEL(edgemode = "directed",
              nodes    = names(d))

# Edges defined here.
g <- addEdge("tstsc", "salar", g)
g <- addEdge("tstsc", "spend", g)
g <- addEdge("tstsc", "apret", g)
g <- addEdge("tstsc", "top10", g)

g <- addEdge("top10", "rejr", g)

g <- addEdge("pacc", "salar", g)

g <- addEdge("salar", "spend", g)
g <- addEdge("salar", "rejr", g)

g <- addEdge("rejr", "spend", g)

g <- addEdge("strat", "apret", g)
g <- addEdge("strat", "spend", g)

model = list(name  = "Retention-MN",
             graph = g,
             data  = intervalScale(d))

class(model) <- "model"
models[[length(models) + 1]] <- model

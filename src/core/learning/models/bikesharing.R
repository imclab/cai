# Christopher L. Simons, 2013

model <- list()

d <- read.csv("data/bikesharing-daily-custom.csv", header = TRUE)
d <- data.frame(interval_scale(as.matrix(d)))

g <- graphNEL(edgemode = "directed",
              nodes    = names(d))

# Edges defined here.
g <- addEdge("mnth", "season", g)
g <- addEdge("mnth", "temp", g)
g <- addEdge("season", "mnth", g)

g <- addEdge("season", "registered", g)
g <- addEdge("season", "casual", g)

g <- addEdge("temp", "registered", g)
g <- addEdge("temp", "casual", g)

g <- addEdge("mnth", "registered", g)
g <- addEdge("mnth", "casual", g)

g <- addEdge("weathersit", "registered", g)
g <- addEdge("weathersit", "casual", g)

g <- addEdge("workingday", "registered", g)
g <- addEdge("workingday", "casual", g)

g <- addEdge("registered", "cnt", g)
g <- addEdge("casual", "cnt", g)

model = list(name  = "bikesharing",
             graph = g,
             data  = interval_scale(d))

class(model) <- "model"
models[[length(models) + 1]] <- model

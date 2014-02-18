# Christopher L. Simons, 2013

model <- list()

d <- read.csv("data/bikesharing-daily.csv", header = TRUE)
d <- data.frame(interval_scale(as.matrix(d)))

g <- graphNEL(edgemode = "directed",
              nodes    = names(d))

# Edges defined here.
g <- addEdge("mnth", "season", g)
g <- addEdge("weekday", "workingday", g)
g <- addEdge("holiday", "workingday", g)
g <- addEdge("mnth", "temp", g)
g <- addEdge("temp", "casual", g)
g <- addEdge("temp", "registered", g)
g <- addEdge("temp", "atemp", g)
g <- addEdge("atemp", "temp", g)
g <- addEdge("mnth", "casual", g)
g <- addEdge("weathersit", "casual", g)
g <- addEdge("weathersit", "registered", g)
g <- addEdge("registered", "cnt", g)
g <- addEdge("casual", "cnt", g)

model = list(name  = "bikesharing",
             graph = g,
             data  = interval_scale(d))

class(model) <- "model"
models[[length(models) + 1]] <- model

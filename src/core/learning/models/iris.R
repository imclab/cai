# Christopher L. Simons, 2013

model <- list()

d <- read.csv("data/iris.data", header = TRUE)
d <- data.frame(interval_scale(as.matrix(data.)))

g <- graphNEL(nodes=names(d), edgemode="directed")
g <- addEdge("class", "sepal_length", g)
g <- addEdge("class", "sepal_width", g)
g <- addEdge("class", "petal_length", g)
g <- addEdge("class", "petal_width", g)

model = list(name  = "iris",
             graph = g,
             data  = interval_scale(d))

class(model) <- "model"
models[[length(models) + 1]] <- model

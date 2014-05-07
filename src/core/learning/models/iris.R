# Copyright 2013, 2014 by Christopher L. Simons

model <- list()

d <- read.csv("data/iris.csv", header = TRUE)
d <- data.frame(intervalScale(as.matrix(d)))

g <- graphNEL(nodes=names(d), edgemode="directed")
g <- addEdge("class", "sepal_length", g)
g <- addEdge("class", "sepal_width", g)
g <- addEdge("class", "petal_length", g)
g <- addEdge("class", "petal_width", g)

model = list(name  = "iris",
             graph = g,
             data  = intervalScale(d))

class(model) <- "model"
models[[length(models) + 1]] <- model

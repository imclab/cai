# Copyright 2013, 2014 by Christopher L. Simons

model <- list()

d <- read.csv("data/housing.csv", header = TRUE)
d <- data.frame(intervalScale(as.matrix(d)))

g <- graphNEL(edgemode = "directed",
              nodes    = names(d))

#g <- addEdge("temp_outside", "temp_t1", g)

model = list(name  = "housing",
             graph = g,
             data  = intervalScale(d))

class(model) <- "model"
models[[length(models) + 1]] <- model

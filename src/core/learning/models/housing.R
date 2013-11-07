# Christopher L. Simons, 2013

model <- list()

d <- read.csv("data/housing.data", header = TRUE)
d <- data.frame(interval_scale(as.matrix(data.)))

g <- graphNEL(edgemode = "directed",
              nodes    = names(d))

#g <- addEdge("temp_outside", "temp_t1", g)

model = list(name  = "housing",
             graph = g,
             data  = interval_scale(d))

class(model) <- "model"
models[[length(models) + 1]] <- model

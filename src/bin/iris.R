# Christopher L. Simons, 2013

source("src/core/util/util.R")
source("src/conf/properties.R")
source("src/core/util/init.R")
source("src/learning/support/train.R")

data. <- read.csv("data/iris.data", header = TRUE)
data. <- data.frame(interval_scale(as.matrix(data.)))

gold <- graphNEL(nodes=names(data.), edgemode="directed")
gold <- addEdge("class", "sepal_length", gold)
gold <- addEdge("class", "sepal_width", gold)
gold <- addEdge("class", "petal_length", gold)
gold <- addEdge("class", "petal_width", gold)

p("Retention data available as 'data.'.")

results <- list()
for (i in 1:length(learners)) {
    learner <- learners[[i]]
    pn("Learning structure using [", sprintf(fmt_s, learner$name), "] ...")
    result <- learner$learn(data.)
    p(" distance from gold standard = ", shd(gold, result), ".")
    results[[length(results) + 1]] <- result
}

p("Plotting learned structures ...")
par(mfrow = c(2, (ceiling(length(results) / 2))))
for (i in 1:length(results))
    plot(results[[i]])

p("Done.")

# Christopher L. Simons, 2013

source("src/core/util/util.R")
p("Started program at [", date(), "].")
source("src/conf/properties.R")
source("src/core/util/init.R")
source("src/core/learning/support/train.R")

data. <- read.csv("data/housing.data", header = TRUE)
data. <- data.frame(interval_scale(as.matrix(data.)))

#gold <- graphNEL(nodes=names(data.), edgemode="directed")
#gold <- addEdge("class", "sepal_length", gold)
#gold <- addEdge("class", "sepal_width", gold)
#gold <- addEdge("class", "petal_length", gold)
#gold <- addEdge("class", "petal_width", gold)

p("Housing data available as 'data.'.")

results <- list()
for (i in 1:length(learners)) {
    learner <- learners[[i]]
    pn(date(), ": Learning using [", sprintf(fmt_s, learner$name), "] ...")
    result$struct <- learner$learn(data.)
    result$learner.name <- learner$name
    p("") #p(" done; SHD = ", shd(hold, result$struct), ".")
    results[[length(results) + 1]] <- result
}

p("Plotting learned structures ...")
par(mfrow = c(2, (ceiling((length(results) + 1) / 2))))
plot(gold, main = "GS")
for (i in 1:length(results))
    plot(results[[i]]$struct,
         main = gsub("::", "\n", results[[i]]$learner.name))

p("Completed program at [", date(), "] local time.")

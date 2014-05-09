# Copyright 2013, 2014 by Christopher L. Simons

source("src/core/util/init.R")
source("src/core/util/init_learners.R")
p("Started main logic at [", date(), "].")

combo.results.table <<- NULL

model <- NULL
for (i in 1:length(models))
    if (models[[i]][["name"]] == "Retention-MN")
        model <- models[[i]]

results <- list()
for (i in 1:length(learners)) {
    if (learners[[i]]$name == "benchmark") {
        learner <- learners[[i]]
        break;
    }
}

pn(date(), ": Learning using [", sprintf(fmt.s, learner$name), "] ...")
result$struct <- learner$learn(model$data)
p(" done.")

p("Writing results to 'benchmark.csv'.")

combo.results.table <- data.frame(combo.results.table)
names(combo.results.table) <- c("X", "Y", "S", "p-values")

write.csv(combo.results.table, quote=FALSE, row.names=FALSE, file="benchmark.csv")

p("Completed program at [", date(), "] local time.")

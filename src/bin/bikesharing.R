# Copyright 2013, 2014 by Christopher L. Simons

source("src/core/util/init.R")
source("src/core/util/init_learners.R")
p("Started main logic at [", date(), "].")

model <- NULL
for (i in 1:length(models))
    if (models[[i]][["name"]] == "bikesharing")
        model <- models[[i]]

results <- list()
for (i in 1:length(learners))
{
    learner <- learners[[i]]
    pn(date(), ": Learning using [", sprintf(fmt.s, learner$name), "] ...")
    result$struct <- learner$learn(model$data)
    result$learner.name <- learner$name
    p(" done; SHD = ", shd(model$graph, result$struct), ".")
    results[[length(results) + 1]] <- result
}

p("Plotting learned structures ...")
par(mfrow = c(2, (ceiling((length(results) + 1) / 2))))
plot(model$graph, main = "GS")
for (i in 1:length(results))
    plot(results[[i]]$struct,
         main = gsub("::", "\n", results[[i]]$learner.name))

p("Completed program at [", date(), "] local time.")

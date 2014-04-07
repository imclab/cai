# Christopher L. Simons, 2013

source("src/core/util/init.R")
source("src/core/util/init_learners.R")
p("Started main logic at [", date(), "].")

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

p("Completed program at [", date(), "] local time.")

# Christopher L. Simons, 2013

source("src/core/util/init.R")
p("Started program at [", date(), "].")
source("src/core/learning/support/train.R")
source("src/core/util/init_learners.R")

model <- NULL
for (i in 1:length(models))
    if (models[[i]][["name"]] == "bikesharing")
        model <- models[[i]]

results <- list()
for (i in 1:length(learners))
{
    learner <- learners[[i]]
    pn(date(), ": Learning using [", sprintf(fmt_s, learner$name), "] ...")
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

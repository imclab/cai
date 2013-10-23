# Christopher L. Simons, 2013

source("src/core/util/util.R")
source("src/conf/properties.R")
source("src/core/util/init.R")
source("src/learning/support/train.R")

model <- NULL
for (i in 1:length(models))
    if (models[[i]][["name"]] == "temperature.continuous")
        model <- models[[i]]

results <- list()
for (i in 1:length(learners)) {
    learner <- learners[[i]]
    pn("Learning structure using [", sprintf(fmt_s, learner$name), "] ...")
    result$struct <- learner$learn(model$data)
    result$learner.name <- learner$name
    p(" distance from GS = ", shd(model$graph, result$struct), ".")
    results[[length(results) + 1]] <- result
}

p("Plotting learned structures ...")
#par(mfrow = c((ceiling((length(results) + 1) / 2)), 2))
par(mfrow = c(2, (ceiling((length(results) + 1) / 2))))
plot(model$graph, main = "GS")
for (i in 1:length(results))
    plot(results[[i]]$struct,
         main = gsub("::", "\n", results[[i]]$learner.name))

p("Done.")

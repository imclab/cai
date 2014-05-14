# Copyright 2013, 2014 by Christopher L. Simons

source("src/core/util/util.R")

d <- read.csv("benchmark.csv", header = TRUE)

gold.p <- d[,4]
mode.p <- d[,5]
pcor.p <- d[,6]

accuracy.data <- NULL
for (alpha in seq(0, 1, 0.01)) {
    mode.hits <- 0
    pcor.hits <- 0

    for (i in 1:nrow(d)) {
        mode.hits <- mode.hits + if ((gold.p[i] == 1 && mode.p[i] >= alpha)
                                  || (gold.p[i] == 0 && mode.p[i]  < alpha))
                                        1 else 0

        pcor.hits <- pcor.hits + if ((gold.p[i] == 1 && pcor.p[i] >= alpha)
                                  || (gold.p[i] == 0 && pcor.p[i]  < alpha))
                                        1 else 0
    }

    accuracy.data <- rbind(accuracy.data, c(nformat(alpha),
                                            nformat(mode.hits / nrow(d)),
                                            nformat(pcor.hits / nrow(d))))
}

accuracy.df <- data.frame(accuracy.data)

names(accuracy.df) <- c("alpha",
                        "mode.accuracy",
                        "pcor.accuracy")

write.csv(accuracy.df, row.names=FALSE, file="accuracy.csv")

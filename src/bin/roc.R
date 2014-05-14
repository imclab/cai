# Copyright 2013, 2014 by Christopher L. Simons

source("src/core/util/util.R")

d <- read.csv("benchmark.csv", header = TRUE)

gold.p <- d[,4]
mode.p <- d[,5]
pcor.p <- d[,6]

roc.data <- NULL
for (alpha in seq(0, 1, 0.01)) {
    positives.actual <- 0
    negatives.actual <- 0

    mode.hits <- 0
    pcor.hits <- 0

    mode.TP <- 0
    mode.FP <- 0
    mode.TN <- 0
    mode.FN <- 0

    pcor.TP <- 0
    pcor.FP <- 0
    pcor.TN <- 0
    pcor.FN <- 0

    for (i in 1:nrow(d)) {
        positives.actual <- positives.actual + gold.p[i]
        negatives.actual <- negatives.actual + (1 - gold.p[i])

        mode.TP <- mode.TP + if (gold.p[i] == 1 && mode.p[i] >= alpha) 1 else 0
        mode.FP <- mode.FP + if (gold.p[i] == 0 && mode.p[i] >= alpha) 1 else 0
        mode.FN <- mode.FN + if (gold.p[i] == 1 && mode.p[i]  < alpha) 1 else 0
        mode.TN <- mode.TN + if (gold.p[i] == 0 && mode.p[i]  < alpha) 1 else 0

        pcor.TP <- pcor.TP + if (gold.p[i] == 1 && pcor.p[i] >= alpha) 1 else 0
        pcor.FP <- pcor.FP + if (gold.p[i] == 0 && pcor.p[i] >= alpha) 1 else 0
        mode.FN <- mode.FN + if (gold.p[i] == 1 && pcor.p[i]  < alpha) 1 else 0
        mode.TN <- mode.TN + if (gold.p[i] == 0 && pcor.p[i]  < alpha) 1 else 0

        mode.hits <- mode.hits + if ((gold.p[i] == 1 && mode.p[i] >= alpha)
                                  || (gold.p[i] == 0 && mode.p[i] < alpha))
                                        1 else 0

        pcor.hits <- pcor.hits + if ((gold.p[i] == 1 && pcor.p[i] >= alpha)
                                  || (gold.p[i] == 0 && pcor.p[i] < alpha))
                                        1 else 0
    }

    # ROC curve: TPR (true positives / actual positives)
    #               vs. FPR (false positives / actual negatives)
    mode.TPR <- mode.TP / positives.actual
    mode.FPR <- mode.FP / negatives.actual
    pcor.TPR <- pcor.TP / positives.actual
    pcor.FPR <- pcor.FP / negatives.actual

    # F1 score for ROC plot is given by 2TP/(2TP + FP + FN).
    #
    mode.F1 <- (2 * mode.TP) / ((2 * mode.TP) + mode.FP + mode.FN)
    pcor.F1 <- (2 * pcor.TP) / ((2 * pcor.TP) + pcor.FP + pcor.FN)

    row. <- c(nformat(alpha),
              nformat(mode.TPR), nformat(mode.FPR),
              nformat(pcor.TPR), nformat(pcor.FPR))

    roc.data <- rbind(roc.data, row.)

    # Once we've gotten to all zeroes, we can stop.
    doBreak <- TRUE
    for (i in 2:length(row.)) {
p("row.[", i , "] == ", row.[i], "; nformat(0) == ", nformat(0))
        if (row.[i] != nformat(0))
            doBreak <- FALSE
    }
    if (doBreak)
        break
}

roc.df <- data.frame(roc.data)

names(roc.df) <- c("alpha",
                   "mode.TPR",
                   "mode.FPR",
                   "pcor.TPR",
                   "pcor.FPR")

write.csv(roc.df, row.names=FALSE, file="roc.csv")

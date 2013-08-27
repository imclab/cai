# Christopher L. Simons, 2013

source("src/core/plot_disc.R")

assessment <- list(name = "custom_sym", assess = function(data) {
    row_score <- function(row) {
        diff <- 0
        ncomparisons <- floor(length(row) / 2)

        for (i in 1:ncomparisons)
            diff <- diff + abs(row[i] - row[length(row) + 1 - i])

        diff <- diff / ncomparisons
        if ((diff < 0) || (diff > 1))
            verbose("Impossible row diff (should be 0 <= x <= 1): ", diff)

        return (diff)
    }

    axis_score <- function(data) {
        z <- build_plot_matrix(data)
        nrows <- length(z[,1])

        acc_delta <- 0
        for (i in 1:nrows) {
            row <- z[i,]
            row_delta <- row_score(row)
            acc_delta <- acc_delta + row_delta
        }

        return (acc_delta / nrows)
    }

    x <- data[,1]
    y <- data[,2]
    rdata <- cbind(y, x)

    hScore <- axis_score(data)
    vScore <- axis_score(rdata)
    score <- ((hScore + vScore) / 2)

    return (score)
})

class(assessment) <- "assessment"
assessments[[length(assessments) + 1]] <- assessment

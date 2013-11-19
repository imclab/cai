# Christopher L. Simons, 2013

source("src/core/util/plot_disc.R")

assessment <- list(name = "sym_m", assess = function(data) {
    row_score <- function(row) {
        max_diff <- 0
        ncomparisons <- floor(length(row) / 2)

        for (i in 1:ncomparisons)
            #diff <- diff + abs(row[i] - row[length(row) + 1 - i])
            max_diff <- max(max_diff, abs(row[i] - row[length(row) + 1 - i]))

        return (max_diff)
    }

    axis_score <- function(data) {
        z <- build_plot_matrix(data)
        nrows <- length(z[,1])

        max_delta <- 0
        for (i in 1:nrows) {
            row <- z[i,]
            row_delta <- row_score(row)
            max_delta <- max(max_delta, row_delta)
        }

        return (max_delta)
    }

    x <- data[,1]
    y <- data[,2]
    rdata <- cbind(y, x)

    hScore <- axis_score(data)
    vScore <- axis_score(rdata)
    score <- max(hScore, vScore)

    return (score)
})

class(assessment) <- "assessment"
assessments[[assessment$name]] <- assessment

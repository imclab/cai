# Christopher L. Simons, 2013

source("src/core/plot_disc.R")

assess_sym <- list(assess = function(data) {
    row_score <- function(row) {
        diff <- 0

        for (i in 1:floor(length(row) / 2))
            diff <- diff + abs(row[i] - row[length(row) + 1 - i])

        return (diff)
    }

    axis_score <- function(data) {
        z <- build_plot_matrix(data)
        nrows <- length(z[,1])

        cum_delta <- 0
        for (i in 1:nrows) {
            row <- z[i,]
            row_delta <- row_score(row)
            cum_delta <- cum_delta + row_delta
        }

        return (cum_delta / nrows)
    }

    x <- data[,1]
    y <- data[,2]
    rdata <- cbind(y, x)

    hScore <- axis_score(data)
    vScore <- axis_score(rdata)
    score <- ((hScore + vScore) / 2)

    return (score)
})

class(assess_sym) <- "assessment"

assessments <- append(assessments, assess_sym)

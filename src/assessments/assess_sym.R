# Christopher L. Simons, 2013

source("src/core/plot_disc.R")

assess_sym <- list(assess = function(data, alphas) {
    isRowSymmetric <- function(row, alpha) {
        diff <- 0

        for (i in 1:floor(length(row) / 2))
            diff <- diff + abs(row[i] - row[length(row) + 1 - i])

        return (diff < alpha)
    }

    diffSymmetric <- function(row) {
        diff <- 0

        for (i in 1:floor(length(row) / 2))
            diff <- diff + abs(row[i] - row[length(row) + 1 - i])

        return (diff)
    }

    isSymmetric <- function(data, alpha) {
        z <- build_plot_matrix(data)
        nrows <- length(z[,1])
        symmetric <- TRUE

        for (i in 1:nrows) {
            row <- z[i,]
            rowSymmetric <- isRowSymmetric(row, alpha)

            if (verboseMode)
                p(i, ": row is symmetric (", diffSymmetric(row),
                  "<", alpha, ")?: ", rowSymmetric)

            if (! rowSymmetric)
                symmetric <- FALSE
        }

        return (symmetric)
    }

    alpha <- alphas[1]

    x <- data[,1]
    y <- data[,2]
    rdata <- cbind(y, x)

    return (isSymmetric(data, alpha) && isSymmetric(rdata, alpha))
})

class(assess_sym) <- "assessment"

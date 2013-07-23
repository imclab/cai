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

        n_checks <- 0
        n_transgressions <- 0
        for (i in 1:nrows) {
            row <- z[i,]
            rowSymmetric <- isRowSymmetric(row, alpha)

            verbose(i, ": row is symmetric? (", diffSymmetric(row),
                    " < ", alpha, "): ", rowSymmetric)

            n_checks <- n_checks + 1
            if (! rowSymmetric)
                n_transgressions <- n_transgressions + 1
        }

        symmetric <- TRUE
        if ((n_transgressions / n_checks) > param.failure_threshold)
            symmetric <- FALSE

        verbose("checking row-vector symmetry: (",
                n_transgressions, "/", n_checks,
                " = ", (n_transgressions / n_checks),
                ") > (failure_threshold = ", param.failure_threshold,
                "): ", symmetric)

        return (symmetric)
    }

    alpha <- alphas[1]

    x <- data[,1]
    y <- data[,2]
    rdata <- cbind(y, x)

    verbose("Assessing symmetry horizontally ...")
    hSym <- isSymmetric(data, alpha)
    verbose("Horizontally symmetric?: ", hSym)

    verbose("Assessing symmetry vertically ...")
    vSym <- isSymmetric(rdata, alpha)
    verbose("Vertically symmetric?: ", vSym)

    return (hSym && vSym)
})

class(assess_sym) <- "assessment"

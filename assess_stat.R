# Christopher L. Simons, 2013

source("plot_disc.R")

existsDependency <- function(data, alpha_mean, alpha_var) {
    x <- data[,1]
    y <- data[,2]

    breaks_x <- hist(x, plot=FALSE)$breaks
    breaks_y <- hist(y, plot=FALSE)$breaks

    x_bin_values <- c()
    x_bin_means <- c()
    x_bin_variances <- c()
    for (xb in 1:(length(breaks_x) - 1)) {
        for (i in 1:length(data[,1])) {
            xi <- data[i,][1]
            yi <- data[i,][2]
            if (xi >= breaks_x[xb] && xi <= breaks_x[xb + 1]) {
                x_bin_values <- append(x_bin_values, yi)
            }
        }
        x_bin_means <- append(x_bin_means, mean(x_bin_values))
        x_bin_variances <- append(x_bin_variances, var(x_bin_values))
        x_bin_values <- c()
    }

    y_bin_values <- c()
    y_bin_means <- c()
    y_bin_variances <- c()
    for (yb in 1:(length(breaks_y) - 1)) {
        for (i in 1:length(data[,1])) {
            xi <- data[i,][1]
            yi <- data[i,][2]
            if (yi >= breaks_y[yb] && yi <= breaks_y[yb + 1]) {
                y_bin_values <- append(y_bin_values, xi)
            }
        }
        y_bin_means <- append(y_bin_means, mean(y_bin_values))
        y_bin_variances <- append(y_bin_variances, var(y_bin_values))
        y_bin_values <- c()
    }

    obj <- list()
    obj$x_bin_means <- x_bin_means
    obj$x_bin_variances <- x_bin_variances
    obj$y_bin_means <- y_bin_means
    obj$y_bin_variances <- y_bin_variances

    independent_x <- TRUE
    for (i in 2:length(x_bin_means)) {
        if (((x_bin_means[i] != NA) && (x_bin_means[i - 1] != NA))
                && ((x_bin_variances[i] != NA) && (x_bin_variances[i - 1] != NA))) {
            if ((abs(x_bin_means[i]
                        - x_bin_means[i - 1]) > alpha_mean)
                    || (abs(x_bin_variances[i]
                        - x_bin_variances[i - 1]) > alpha_var)) {
                independent_x <- FALSE
            }
        }
    }
    obj$independent_x <- independent_x

    independent_y <- TRUE
    for (i in 2:length(y_bin_means)) {
        if (((y_bin_means[i] != NA) && (y_bin_means[i - 1] != NA))
                && ((y_bin_variances[i] != NA) && (y_bin_variances[i - 1] != NA))) {
            if ((abs(y_bin_means[i]
                        - y_bin_means[i - 1]) > alpha_mean)
                    || (abs(y_bin_variances[i]
                        - y_bin_variances[i - 1]) > alpha_var)) {
                independent_y <- FALSE
            }
        }
    }
    obj$independent_y <- independent_y

    return (obj)
}

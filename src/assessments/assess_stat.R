# Christopher L. Simons, 2013

source("src/core/plot_disc.R")

assess_stat <- list(assess = function(data, alphas) {
    x <- data[,1]
    y <- data[,2]
    alpha_mean <- alphas[1]
    alpha_var  <- alphas[2]

    breaks_x <- hist(x, plot=FALSE)$breaks
    breaks_y <- hist(y, plot=FALSE)$breaks

    x_bin_values <- c()
    x_bin_means <- c()
    x_bin_variances <- c()
    for (xb in 1:(length(breaks_x) - 1)) {
        for (i in 1:length(data[,1])) {
            xi <- data[i,][1]
            yi <- data[i,][2]

            if (xi >= breaks_x[xb] && xi <= breaks_x[xb + 1])
                x_bin_values <- append(x_bin_values, yi)
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

            if (yi >= breaks_y[yb] && yi <= breaks_y[yb + 1])
                y_bin_values <- append(y_bin_values, xi)
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

    #
    # WARNING: Below, sometimes the variances have been calculated as 'NA'
    #          and in these cases we simply skip the comparison.  Is this
    #          case important?
    #

    independent_x <- TRUE
    for (i in 2:length(x_bin_means)) {
        xm_a <- x_bin_means[i - 1]
        xm_b <- x_bin_means[i]
        xv_a <- x_bin_variances[i - 1]
        xv_b <- x_bin_variances[i]

        if (!is.na(xm_a) && !is.na(xm_b) && !is.na(xv_a) && !is.na(xv_b))
            if (abs(xm_b - xm_a) > alpha_mean || abs(xv_b - xv_a) > alpha_var)
                independent_x <- FALSE
    }
    obj$independent_x <- independent_x

    independent_y <- TRUE
    for (i in 2:length(y_bin_means)) {
        ym_a <- y_bin_means[i - 1]
        ym_b <- y_bin_means[i]
        yv_a <- y_bin_variances[i - 1]
        yv_b <- y_bin_variances[i]

        if (!is.na(ym_a) && !is.na(ym_b) && !is.na(yv_a) && !is.na(yv_b))
            if (abs(ym_b - ym_a) > alpha_mean || abs(yv_b - yv_a) > alpha_var)
                independent_y <- FALSE
    }
    obj$independent_y <- independent_y

    return (obj$independent_x && obj$independent_y)
})

class(assess_stat) <- "assessment"

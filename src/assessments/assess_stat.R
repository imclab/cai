# Christopher L. Simons, 2013

source("src/core/plot_disc.R")

assess_stat <- list(assess = function(data, alphas) {
    isIndependentX <- function(data, alpha_mean, alpha_var) {
        x <- data[,1]
        breaks_x <- hist(x, plot=FALSE)$breaks

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

        return (independent_x)
    }

    alpha_mean <- alphas[1]
    alpha_var  <- alphas[2]

    x <- data[,1]
    y <- data[,2]
    rdata <- cbind(y, x)

    return (isIndependentX(data, alpha_mean, alpha_var)
                && isIndependentX(rdata, alpha_mean, alpha_var))
})

class(assess_stat) <- "assessment"

# Christopher L. Simons, 2013

source("src/core/breaks.R")

assess_stat <- list(assess = function(data) {
    axis_score <- function(data) {
        x <- data[,1]
        breaks_x <- breaks_uniform_width(x, param.disc_bins)

        # Walk along x-axis creating vertical "stripe" bins.

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

        # Walk along vertical "stripe" bins comparing delta in mean, variance.

        cum_diff_mean <- 0
        cum_diff_var  <- 0
        for (i in 2:length(x_bin_means)) {
            xm_a <- x_bin_means[i - 1]
            xm_b <- x_bin_means[i]
            xv_a <- x_bin_variances[i - 1]
            xv_b <- x_bin_variances[i]

            # TODO: What is the significance of skipping "NA" comparisons
            #       (NA due to division by zero in earlier calculations)?

            if (!is.na(xm_a) && !is.na(xm_b) && !is.na(xv_a) && !is.na(xv_b)) {
                diff_mean <- abs(xm_b - xm_a)
                diff_var <- abs(xv_b - xv_a)
                cum_diff_mean <- cum_diff_mean + diff_mean
                cum_diff_var  <- cum_diff_var + diff_var
            }
        }

        cum_diff_mean <- cum_diff_mean / (length(x_bin_means) - 1)
        cum_diff_var  <- cum_diff_var  / (length(x_bin_means) - 1)

        return ((cum_diff_mean + cum_diff_var) / 2)
    }

    x <- data[,1]
    y <- data[,2]
    rdata <- cbind(y, x)

    hScore <- axis_score(data)
    vScore <- axis_score(rdata)
    score <- ((hScore + vScore) / 2)

    return (score)
})

class(assess_stat) <- "assessment"

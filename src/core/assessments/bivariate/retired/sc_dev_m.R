# Christopher L. Simons, 2013

source("src/core/util/breaks.R")

assessment <- list(name = "sc_dev_m", assess = function(data) {
    axis_score <- function(data) {
        x <- data[,1]
        breaks_x <- breaks_uniform_width(x, bin_count(nrow(data)))

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

            x_bin_means <- append(x_bin_means,
                                  if (length(x_bin_values) > 0)
                                      mean(x_bin_values)
                                  else
                                      0)
            x_bin_variances <- append(x_bin_variances,
                                      if (length(x_bin_values) > 0)
                                          var(x_bin_values)
                                      else
                                          0)
            x_bin_values <- c()
        }

        y <- data[,2]
        overall_mean <- mean(y)
        overall_var <- var(y)

        # Walk along vertical "stripe" bins comparing delta in mean, variance.

        max_diff <- 0
        ncomparisons <- length(x_bin_means)
        for (i in 1:ncomparisons) {
            diff_mean <- abs(overall_mean - x_bin_means[i])
            diff_var <- abs(overall_var - x_bin_variances[i])
            max_diff <- max(max_diff, diff_mean, diff_var)
        }

        return (max_diff)
    }

    x <- data[,1]
    y <- data[,2]
    rdata <- cbind(y, x)

    hScore <- navl(axis_score(data), 0)
    vScore <- navl(axis_score(rdata), 0)
    score <- navl(max(hScore, vScore), 0)

    return (score)
})

class(assessment) <- "assessment"
assessments[[assessment$name]] <- assessment

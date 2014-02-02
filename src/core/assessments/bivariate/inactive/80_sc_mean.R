# Christopher L. Simons, 2013

source("src/core/util/breaks.R")

assessment <- list(name = "SC_{\\overline{x}}", assess = function(data) {
    axis_score <- function(data) {
        x <- data[,1]
        breaks_x <- breaks_uniform_width(x, bin_count(nrow(data)))

        # Walk along x-axis creating vertical "stripe" bins.

        x_bin_values <- c()
        x_bin_means <- c()
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
            x_bin_values <- c()
        }

        y <- data[,2]
        overall_mean <- mean(y)

        # Find maximum discrepancy between a partition and the whole plot.

        max_diff <- 0
        ncomparisons <- length(x_bin_means)
        for (i in 1:ncomparisons) {
            diff_mean <- abs(overall_mean - x_bin_means[i])
            max_diff <- max(max_diff, diff_mean)
        }

        return (max_diff)
    }

    return (navl(axis_score(data), 0))
})

class(assessment) <- "assessment"
assessments[[assessment$name]] <- assessment

# Christopher L. Simons, 2013

source("src/core/util/breaks.R")

assessment <- list(name = "SC_{Mo}", assess = function(data) {
    axis_score <- function(data) {
        x <- data[,1]
        breaks_x <- breaks_uniform_width(x, bin_count(nrow(data)))

        # Walk along x-axis creating vertical "stripe" bins.

        x_bin_values <- c()
        x_bin_modes <- c()
        for (xb in 1:(length(breaks_x) - 1)) {
            for (i in 1:length(data[,1])) {
                xi <- data[i,][1]
                yi <- data[i,][2]

                if (xi >= breaks_x[xb] && xi <= breaks_x[xb + 1])
                    x_bin_values <- append(x_bin_values, yi)
            }

            x_bin_modes <- append(x_bin_modes,
                                  if (length(x_bin_values) > 0)
                                      Mode(x_bin_values)
                                  else
                                      0)
            x_bin_values <- c()
        }

        y <- data[,2]
        overall_mode <- Mode(y)

        # Find maximum discrepancy between a partition and the whole plot.

        max_diff <- 0
        ncomparisons <- length(x_bin_modes)
        for (i in 1:ncomparisons) {
            diff_mode <- abs(overall_mode - x_bin_modes[i])
            max_diff <- max(max_diff, diff_mode)
        }

        return (max_diff)
    }

    return (navl(axis_score(data), 0))
})

class(assessment) <- "assessment"
assessments[[assessment$name]] <- assessment

# Christopher L. Simons, 2013

source("src/core/util/breaks.R")

create_sc_assessment <- function(stat_tex_name, fn_name) {
    assessment <- list(name = paste("SC_{", stat_tex_name, "}", sep=""), assess = function(data) {
        axis_score <- function(data) {
            x <- data[,1]
            breaks_x <- breaks_uniform_width(x, bin_count(nrow(data)))

            # Walk along x-axis creating vertical "stripe" bins.

            x_bin_stats <- c()

            for (xb in 1:(length(breaks_x) - 1)) {
                bin_values <- c()

                for (i in 1:length(data[,1])) {
                    xi <- data[i,][1]
                    yi <- data[i,][2]

                    if (xi >= breaks_x[xb] && xi <= breaks_x[xb + 1])
                        bin_values <- append(bin_values, yi)
                }

                x_bin_stats <- append(x_bin_stats,
                                    if (length(bin_values) > 0)
                                        get(fn_name)(bin_values)
                                    else
                                        0)
            }

            y <- data[,2]
            overall_stat <- get(fn_name)(y)

            # Find maximum discrepancy between a partition and the whole plot.

            max_bin_deviation <- 0
            ncomparisons <- length(x_bin_stats)
            for (i in 1:ncomparisons) {
                bin_deviation <- abs(overall_stat - x_bin_stats[i])
                if (!is.na(bin_deviation))
                    max_bin_deviation <- max(max_bin_deviation, bin_deviation)
            }

            return (max_bin_deviation)
        }

        return (navl(axis_score(data), 0))
    })
    class(assessment) <- "assessment"
    return (assessment)
}

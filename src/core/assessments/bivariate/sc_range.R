# Christopher L. Simons, 2013

source("src/core/util/breaks.R")

assessment <- list(name = "sc_range", assess = function(data) {
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

        result <- max(navl(abs(max(x_bin_means)
                        - min(x_bin_means)), 0),
                    navl(abs(max(x_bin_variances)
                        - min(x_bin_variances)), 0))

        return (navl(result, 0))
    }

    x <- data[,1]
    y <- data[,2]
    rdata <- cbind(y, x)

    hScore <- axis_score(data)
    vScore <- axis_score(rdata)
    score <- max(hScore, vScore)

    return (score)
})

class(assessment) <- "assessment"
assessments[[assessment$name]] <- assessment

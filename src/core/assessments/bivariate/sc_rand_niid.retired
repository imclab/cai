# Christopher L. Simons, 2013

source("src/core/util/breaks.R")

assessment <- list(name = "sc_rand_niid", assess = function(data) {
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

        # Walk along vertical "stripe" bins comparing delta in mean, variance.

        max_diff <- 0
        ncomparisons <- length(x_bin_means)
        bins_compared <- c()
        while ((length(bins_compared) + 1) < ncomparisons) {
            i <- (-1)
            while (i < 0 || i %in% bins_compared)
                i <- round(runif(1, 1, ncomparisons))

            j <- (-1)
            while (j < 0 || j %in% bins_compared)
                j <- round(runif(1, 1, ncomparisons))

            xm_a <- x_bin_means[i]
            xm_b <- x_bin_means[j]
            xv_a <- x_bin_variances[i]
            xv_b <- x_bin_variances[j]

            # TODO: What is the significance of skipping "NA" comparisons
            #       (NA due to division by zero in earlier calculations)?

            if (!is.na(xm_a) && !is.na(xm_b) && !is.na(xv_a) && !is.na(xv_b)) {
                diff_mean <- abs(xm_b - xm_a)
                diff_var <- abs(xv_b - xv_a)
                max_diff <- max(max_diff, diff_mean, diff_var)
            }

            bins_compared <- append(bins_compared, i)
            bins_compared <- append(bins_compared, j)
        }

        return (max_diff)
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

# Christopher L. Simons, 2013

source("src/core/util/init.R")
p("Started program at [", date(), "].")
source("src/core/util/plot_disc.R")

name_friendly <- function(nom) {
    nom <- gsub("::1", "", nom)
    nom <- gsub("\\\\", "", nom)
    nom <- gsub(" ", "_", nom)
    return (nom)
}

examine_variance <- function(data, gen_name) { # Adapted from 81_sc_variance.R.
    x <- data[,1]
    breaks_x <- breaks_uniform_width(x, bin_count(nrow(data)))

    # Walk along x-axis creating vertical "stripe" bins.

    x_bin_values <- c()
    x_bin_variances <- c()
    for (xb in 1:(length(breaks_x) - 1)) {
        for (i in 1:length(data[,1])) {
            xi <- data[i,][1]
            yi <- data[i,][2]

            if (xi >= breaks_x[xb] && xi <= breaks_x[xb + 1])
                x_bin_values <- append(x_bin_values, yi)
        }

        x_bin_variances <- append(x_bin_variances,
                                  if (length(x_bin_values) > 0)
                                      var(x_bin_values)
                                  else
                                      0)
        x_bin_values <- c()
    }

    y <- data[,2]
    overall_variance <- var(y)

    # Find maximum discrepancy between a partition and the whole plot.

    max_diff <- 0
    ncomparisons <- length(x_bin_variances)
    for (i in 1:ncomparisons) {
        p("var-comp: ", gen_name, ": var_i / overall = ",
          x_bin_variances[i], " / ", overall_variance)
        diff_variance <- abs(overall_variance - x_bin_variances[i])
        max_diff <- max(max_diff, diff_variance)
    }

    return (max_diff)
}

for (generator in generators) {
    if (generator$name == "x::1"
            || generator$name == "x \\times \\noise::1"
            || generator$name == "\\noise_1::1") {
        data <- generator$generate(training.n)
        data <- interval_scale(data)

        nom <- name_friendly(generator$name)
        examine_variance(data, nom)
        plot_disc(data,
                  filename=paste("variance-comp/", nom, ".png", sep=""),
                  fill=FALSE,
                  gradient=TRUE,
                  debug=FALSE)
    }
}

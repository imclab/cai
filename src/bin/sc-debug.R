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

sc_debug <- function(data, gen_name, fnSS) {
    x <- data[,1]
    breaks_x <- breaks_uniform_width(x, bin_count(nrow(data)))

    # Walk along x-axis creating vertical "stripe" bins.

    x_bin_values <- c()
    x_bin_stats <- c()
    for (xb in 1:(length(breaks_x) - 1)) {
        for (i in 1:length(data[,1])) {
            xi <- data[i,][1]
            yi <- data[i,][2]

            if (xi >= breaks_x[xb] && xi <= breaks_x[xb + 1])
                x_bin_values <- append(x_bin_values, yi)
        }

        x_bin_stats <- append(x_bin_stats,
                              if (length(x_bin_values) > 0)
                                  get(fnSS)(x_bin_values)
                              else
                                  0)
        x_bin_values <- c()
    }

    y <- data[,2]
    overall_stat <- var(y)

    # Find maximum discrepancy between a partition and the whole plot.

    max_diff <- 0
    ncomparisons <- length(x_bin_stats)
    for (i in 1:ncomparisons) {
        p("sc-debug: ", gen_name,
          ": ", fnSS, "_i / ", fnSS, " = ",
          x_bin_stats[i], " / ", overall_stat)
        diff_stat <- abs(overall_stat - x_bin_stats[i])
        max_diff <- max(max_diff, diff_stat)
    }

    return (max_diff)
}

for (generator in generators) {
    if (generator$name == "x::1"
            || generator$name == "x \\times \\noise::1"
            || generator$name == "\\noise_1::1") {
        data <- generator$generate(training.n)
        data <- interval_scale(data)

        fnSS <- "var"
        nom <- name_friendly(generator$name)
        sc_debug(data, nom, fnSS)
        plot_disc(data,
                  filename=paste("sc-debug/", fnSS, "-", nom, ".png", sep=""),
                  fill=FALSE,
                  gradient=TRUE,
                  debug=FALSE)
    }
}
p("Program completed at [", date(), "].")

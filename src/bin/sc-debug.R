# Christopher L. Simons, 2013

source("src/core/util/init.R")
source("src/core/util/plot_disc.R")
p("Started main logic at [", date(), "].")

nameFriendly <- function(nom)
{
    nom <- gsub("::1", "", nom)
    nom <- gsub("\\\\", "", nom)
    nom <- gsub(" ", "_", nom)
    return (nom)
}

scDebug <- function(data, gen.name, fnSS)
{
    x <- data[,1]
    breaks.x <- breaks.uniform.width(x, binCount(nrow(data)))

    # Walk along x-axis creating vertical "stripe" bins.

    x.bin.values <- c()
    x.bin.stats <- c()
    for (xb in 1:(length(breaks.x) - 1))
    {
        for (i in 1:length(data[,1]))
        {
            xi <- data[i,][1]
            yi <- data[i,][2]

            if (xi >= breaks.x[xb] && xi <= breaks.x[xb + 1])
                x.bin.values <- append(x.bin.values, yi)
        }

        x.bin.stats <- append(x.bin.stats,
                              if (length(x.bin.values) > 0)
                                  get(fnSS)(x.bin.values)
                              else
                                  0)
        x.bin.values <- c()
    }

    y <- data[,2]
    overall.stat <- var(y)

    # Find maximum discrepancy between a partition and the whole plot.

    max.diff <- 0
    ncomparisons <- length(x.bin.stats)
    for (i in 1:ncomparisons)
    {
        p("sc-debug: ", gen.name,
          ": |", fnSS, " - ", fnSS, "_i| = |",
          nformat(overall.stat), " - ", nformat(x.bin.stats[i]),
          "| = ", nformat(abs(overall.stat - x.bin.stats[i])))
        diff.stat <- abs(overall.stat - x.bin.stats[i])
        if (!is.na(diff.stat))
            max.diff <- max(max.diff, diff.stat)
    }
    p("sc-debug: ", gen.name, ": max deviation = ", nformat(max.diff))

    return (max.diff)
}

for (generator in generators)
{
    if (generator$name == "x::1"
            || generator$name == "x \\times \\noise::1"
            || generator$name == "\\noise_1::1")
    {
        data <- generator$generate(training.n)
        data <- interval_scale(data)

        fnSS <- "var"
        nom <- nameFriendly(generator$name)
        scDebug(data, nom, fnSS)
        plotDisc(data,
                  filename=paste("sc-debug/", fnSS, "-", nom, ".png", sep=""),
                  fill=FALSE,
                  gradient=TRUE,
                  debug=FALSE)
    }
}
p("Program completed at [", date(), "].")

# Christopher L. Simons, 2013

createSCAssessment <- function(stat.tex.name, fn.name)
{
    assessment <- list(name=paste("SC_{", stat.tex.name, "}", sep=""), assess=function(data)
    {
        axisScore <- function(data)
        {
            x <- data[,1]
            breaks.x <- breaksUniformWidth(x, binCount(nrow(data)))

            # Walk along x-axis creating vertical "stripe" bins.

            x.bin.stats <- c()

            for (xb in 1:(length(breaks.x) - 1)) {
                bin.values <- c()

                for (i in 1:length(data[,1])) {
                    xi <- data[i,][1]
                    yi <- data[i,][2]

                    if (xi >= breaks.x[xb] && xi <= breaks.x[xb + 1])
                        bin.values <- append(bin.values, yi)
                }

                x.bin.stats <- append(x.bin.stats,
                                    if (length(bin.values) > 0)
                                        get(fn.name)(bin.values)
                                    else
                                        0)
            }

            y <- data[,2]
            overall.stat <- get(fn.name)(y)

            # Find maximum discrepancy between a partition and the whole plot.

            max.bin.deviation <- 0
            ncomparisons <- length(x.bin.stats)
            for (i in 1:ncomparisons) {
                bin.deviation <- abs(overall.stat - x.bin.stats[i])
                if (!is.na(bin.deviation))
                    max.bin.deviation <- max(max.bin.deviation, bin.deviation)
            }

            return (max.bin.deviation)
        }

        return (navl(axisScore(data), 0))
    })
    class(assessment) <- "assessment"
    return (assessment)
}

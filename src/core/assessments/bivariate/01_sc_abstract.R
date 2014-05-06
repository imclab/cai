# Christopher L. Simons, 2013

createSCAssessment <- function(stat.tex.name, fn.name)
{
    assessment <- list(name=paste("SC_{", stat.tex.name, "}", sep=""), assess=function(data)
    {
        axisScore <- function(data)
        {
            data <- data[order(data[,1]),] # Sort by first column.
            breaks.x <- breaksUniformWidth(data[,1],
                                           binCount(nrow(data)),
                                           preSorted=TRUE)

            # Walk along x-axis creating partitions.

            all.values <- c()
            partition.stats <- c()
            for (xb in 1:(length(breaks.x) - 1)) {
                if (length(all.values) == nrow(data))
                    break

                partition.values <- c()

                for (i in (1 + length(all.values)):nrow(data)) {
                    xi <- data[i,][1]
                    yi <- data[i,][2]

                    if (xi >= breaks.x[xb] && xi <= breaks.x[xb + 1])
                        partition.values <- append(partition.values, yi)
                    else
                        break # Sorted, so once we get here we're done.
                }

                all.values <- append(all.values, partition.values)

                if (length(partition.values) >= min.test.n)
                    partition.stats <- append(partition.stats,
                                              get(fn.name)(partition.values))
            }

            overall.stat <- get(fn.name)(data[,2])

            # Find maximum discrepancy between a partition and the whole plot.

            max.deviation <- 0
            ncomparisons <- length(partition.stats)
            if (ncomparisons > 0) {
                for (i in 1:ncomparisons) {
                    deviation <- abs(overall.stat - partition.stats[i])
                    if (!is.na(deviation))
                        max.deviation <- max(max.deviation, deviation)
                }
            }

            return (max.deviation)
        }

#        return (navl(axisScore(data), 0))
        a <- (navl(axisScore(data), 0))
        b <- (navl(axisScore(cbind(data[,2], data[,1])), 0)) # Swap axes.
        return (max(c(a, b)))
    })
    class(assessment) <- "assessment"
    return (assessment)
}

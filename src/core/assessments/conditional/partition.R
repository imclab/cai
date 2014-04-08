# Christopher L. Simons, 2013

# sufficient.stat should be an object containing:
#
#   assessment : a bivariate assessment.
#   data       : a data frame
#

ci.test.partition <- function(x, y, S, sufficient.stat) {
    data. <- sufficient.stat$data
    assessment <- sufficient.stat$assessment

    if (is.null(data.))
        stop("ci.test.partition: sufficient.stat$data is NULL.")
    if (is.null(assessment))
        stop("ci.test.partition: sufficient.stat$assessment is NULL.")

    x. <- data.[,x]
    y. <- data.[,y]
    S. <- as.matrix(data.[,S])

    scores <- c()
    if (ncol(S.) > 0)
    {
        for (Si in 1:ncol(S.))
        {
            z. <- S.[,Si]

            breaks.z <- breaksUniformWidth(z., binCount(length(z.)))
            xyz.df <- data.frame(cbind(x., y., z.))

            for (zb in 1:(length(breaks.z) - 1))
            {
                xy.subset <- subset(xyz.df,
                                    subset = (  z. >= breaks.z[zb]
                                              & z. <= breaks.z[zb + 1]),
                                    select = c(x., y.))

                xy.matrix <- cbind(xy.subset$x., xy.subset$y.)

                # May not have data for all intervals.
                if (length(xy.matrix) > 0)
                {
                    bivariate.score <- assessment$assess(xy.matrix)
                    scores <- append(scores, bivariate.score)
                }
            }
        }
    }
    else
    {
        scores <- append(scores, assessment$assess(cbind(x., y.)))
    }

    highest <- max(scores)
    verbose("Called ci.test.partition:", x, ",", y, ",[|", ncol(S.),
      "|]\t-> ", "p : alpha = ", nformat(highest), " : ",
      nformat(assessment$alpha_mid), ".")

    return (highest)
}

# Christopher L. Simons, 2013

ciComp <- function(x, y, S, sufficient.stat) {
    data. <- sufficient.stat$data
    bivariate.test <- sufficient.stat$bivariate.test
    if (is.null(data.))
        stop("sufficient.stat$data is NULL.")
    if (is.null(bivariate.test))
        stop("sufficient.stat$bivariate.test is NULL.")

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
                    bivariate.score <- bivariate.test$assess(xy.matrix)
                    scores <- append(scores, bivariate.score)
                }
            }
        }
    }
    else
    {
        scores <- append(scores, bivariate.test$assess(cbind(x., y.)))
    }

    highest <- max(scores)
    verbose("Called ciComp:", x, ",", y, ",[|", ncol(S.),
      "|]\t-> ", "p : alpha = ", nformat(highest), " : ",
      nformat(thresholds[[bivariate.test$name]]), ".")

    return (highest)
}

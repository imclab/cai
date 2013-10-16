# Christopher L. Simons, 2013

ci_comp <- function(x, y, S, suffStat) {
    stopifnot(exists("customCI"))
    bivariate_test <- customCI$bivariate_test
    threshold <- customCI$threshold
    if (is.null(bivariate_test))
        stop("customCI$bivariate_test is NULL.")
    if (is.null(threshold))
        stop("customCI$threshold is NULL.")

    x. <- suffStat[,x]
    y. <- suffStat[,y]
    S. <- as.matrix(suffStat[,S])

    highest <- NULL

    if (ncol(S.) > 0) {
        for (Si in 1:ncol(S.)) {
            z. <- S.[,Si]

            breaks_z <- breaks_uniform_width(z., param.disc_bins)
            xyz_df <- data.frame(cbind(x., y., z.))

            for (zb in 1:(length(breaks_z) - 1)) {
                xy_subset <- subset(xyz_df,
                                    subset = (  z. >= breaks_z[zb]
                                              & z. <= breaks_z[zb + 1]),
                                    select = c(x, y))

                xy_matrix <- cbind(xy_subset$x, xy_subset$y)

                # May not have data for all intervals.
                if (length(xy_matrix) > 0) {
                    bivariate_score <- bivariate_test(xy_matrix)
                    if (is.null(highest))
                        highest <- bivariate_score
                    else if (bivariate_score > highest)
                        highest <- bivariate_score
                }
            }
        }
    } else {
        highest <- bivariate_test(cbind(x., y.))
    }

    if (highest > threshold)
        result <- 1
    else
        result <- 0

    return (result)
}

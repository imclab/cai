# Christopher L. Simons, 2013

ci_comp <- function(x, y, S, suffStat) {
    data. <- suffStat$data
    bivariate_test <- suffStat$bivariate_test
    if (is.null(data.))
        stop("suffStat$data is NULL.")
    if (is.null(bivariate_test))
        stop("suffStat$bivariate_test is NULL.")

    x. <- data.[,x]
    y. <- data.[,y]
    S. <- as.matrix(data.[,S])

#p("Called ci_comp(", x, ", ", y, ", ", S,
#  ", |x| = ", length(x.), "; |y| = ", length(y.),
#  ". [# of conditioning variables = ", ncol(S.), "]).")
    highest <- NULL
    if (ncol(S.) > 0) {
        for (Si in 1:ncol(S.)) {
            z. <- S.[,Si]

            breaks_z <- breaks_uniform_width(z., bin_count(nrow(z.)))
            xyz_df <- data.frame(cbind(x., y., z.))

            for (zb in 1:(length(breaks_z) - 1)) {
                xy_subset <- subset(xyz_df,
                                    subset = (  z. >= breaks_z[zb]
                                              & z. <= breaks_z[zb + 1]),
                                    select = c(x., y.))

                xy_matrix <- cbind(xy_subset$x., xy_subset$y.)

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
#p("Called ci_comp(", x, ", ", y, ", ", S,
#  ", |x| = ", length(x.), "; |y| = ", length(y.),
#  ". [# of conditioning variables = ", ncol(S.), "]) --> ",
#  "p::alpha = [", highest, "]::[", thresholds$custom_sc_oppo, "].")
    return (highest)
}

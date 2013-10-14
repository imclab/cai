# Christopher L. Simons, 2013

source("src/conf/properties.R")

ci_comp <- function(x, y, z, bivariate_test) {
    breaks_z <- breaks_uniform_width(z, param.disc_bins)

    xyz_df <- data.frame(cbind(x, y, z))

    highest <- NULL
    for (zb in 1:(length(breaks_z) - 1)) {
        xy_subset <- subset(xyz_df,
                            subset = (  z >= breaks_z[zb]
                                      & z <= breaks_z[zb + 1]),
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
    return (highest)
}

ci_comp.test <- function(x, y, z, bivariate_test, threshold_dep) {
    return (abs(ci_comp(x, y, z)) >= threshold)
}

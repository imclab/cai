# Christopher L. Simons, 2013

source("src/core/plot_disc.R")

assess_stat <- list(assess = function(data, alphas) {
    isIndependent <- function(data, alpha_mean, alpha_var) {
        x <- data[,1]
        breaks_x <- hist(x, plot=FALSE)$breaks

        #
        # Walk along x-axis creating vertical "stripe" bins.
        #

        x_bin_values <- c()
        x_bin_means <- c()
        x_bin_variances <- c()
        for (xb in 1:(length(breaks_x) - 1)) {
            for (i in 1:length(data[,1])) {
                xi <- data[i,][1]
                yi <- data[i,][2]

                if (xi >= breaks_x[xb] && xi <= breaks_x[xb + 1])
                    x_bin_values <- append(x_bin_values, yi)
            }

            x_bin_means <- append(x_bin_means, mean(x_bin_values))
            x_bin_variances <- append(x_bin_variances, var(x_bin_values))
            x_bin_values <- c()
        }

        #
        # Walk along vertical "stripe" bins comparing delta in mean, variance.
        #
        # WARNING: Sometimes the variances have been calculated as 'NA' and in
        #          these cases we simply skip the comparison.  What is the
        #          significance of this?
        #

        independent_x <- TRUE
        for (i in 2:length(x_bin_means)) {
            xm_a <- x_bin_means[i - 1]
            xm_b <- x_bin_means[i]
            xv_a <- x_bin_variances[i - 1]
            xv_b <- x_bin_variances[i]

            if (!is.na(xm_a) && !is.na(xm_b) && !is.na(xv_a) && !is.na(xv_b)) {
                comp_mean_transgress <- (abs(xm_b - xm_a) > alpha_mean)
                verbose("mean comparison: abs(", xm_b, " - ", xm_a, ") > ",
                        alpha_mean, " ?: ", comp_mean_transgress)

                comp_var_transgress  <- (abs(xv_b - xv_a) > alpha_var)
                verbose("variance comparison: abs(", xv_b, " - ", xv_a, ") > ",
                        alpha_var, " ?: ", comp_var_transgress)

                if (comp_mean_transgress || comp_var_transgress)
                    independent_x <- FALSE
            }
        }

        return (independent_x)
    }

    alpha_mean <- alphas[1]
    alpha_var  <- alphas[2]

    x <- data[,1]
    y <- data[,2]
    rdata <- cbind(y, x)

    verbose("Assessing independence walking horizontally ...")
    hInd <- isIndependent(data, alpha_mean, alpha_var)
    verbose("Horizontally independent?: ", hInd)

    verbose("Assessing independence walking vertically ...")
    vInd <- isIndependent(rdata, alpha_mean, alpha_var)
    verbose("Vertically independent?: ", vInd)

    return (hInd && vInd)
})

class(assess_stat) <- "assessment"

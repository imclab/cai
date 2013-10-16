# Christopher L. Simons, 2013

ci_pcor <- function(x, y, S, suffStat) {
    stopifnot(exists("customCI"))
    method_cor <- customCI$method_cor
    if (is.null(method_cor))
        stop("customCI$method_cor is NULL.")

    x. <- suffStat[,x]
    y. <- suffStat[,y]
    S. <- as.matrix(suffStat[,S])

    resid_xz <- residuals(lm(formula = x. ~ S.))
    resid_yz <- residuals(lm(formula = y. ~ S.))
    return (cor(x      = resid_xz,
                y      = resid_yz,
                use    = "complete.obs",
                method = method_cor))
}

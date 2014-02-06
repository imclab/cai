# Christopher L. Simons, 2013

ci_pcor <- function(x, y, S, suffStat) {
    data. <- suffStat$data
    method_cor <- suffStat$method_cor
    if (is.null(data.))
        stop("suffStat$data is NULL.")
    if (is.null(method_cor))
        stop("suffStat$method_cor is NULL.")

    x. <- data.[,x]
    y. <- data.[,y]
    S. <- as.matrix(data.[,S])
    if (ncol(S.) > 0) {
        resid_xz <- residuals(lm(formula = x. ~ S.))
        resid_yz <- residuals(lm(formula = y. ~ S.))
        result <- if (method_cor == "dcor")
                      dcor(x = resid_xz, y = resid_yz)
                  else
                      abs(cor(x      = resid_xz,
                              y      = resid_yz,
                              use    = "complete.obs",
                              method = method_cor))
    } else {
        result <- if (method_cor == "dcor")
                      dcor(x = x., y = y.)
                  else
                      abs(cor(x      = x.,
                              y      = y.,
                              use    = "complete.obs",
                              method = method_cor))
    }

    verbose("Called ci_pcor:", x, ",", y, ",[|", ncol(S.),
      "|]\t-> ", nformat(result), ".")

    return (result)
}

# Christopher L. Simons, 2013

ciPCor <- function(x, y, S, suffStat)
{
    data. <- suffStat$data
    method.cor <- suffStat$method.cor
    if (is.null(data.))
        stop("suffStat$data is NULL.")
    if (is.null(method.cor))
        stop("suffStat$method.cor is NULL.")

    x. <- data.[,x]
    y. <- data.[,y]
    S. <- as.matrix(data.[,S])
    if (ncol(S.) > 0)
    {
        resid.xz <- residuals(lm(formula = x. ~ S.))
        resid.yz <- residuals(lm(formula = y. ~ S.))
        result <- if (method.cor == "dcor")
                      dcor(x = resid.xz, y = resid.yz)
                  else
                      abs(cor(x      = resid.xz,
                              y      = resid.yz,
                              use    = "complete.obs",
                              method = method.cor))
    }
    else
    {
        result <- if (method.cor == "dcor")
                      dcor(x = x., y = y.)
                  else
                      abs(cor(x      = x.,
                              y      = y.,
                              use    = "complete.obs",
                              method = method.cor))
    }

    verbose("Called ciPCor:", x, ",", y, ",[|", ncol(S.),
      "|]\t-> ", nformat(result), ".")

    return (result)
}

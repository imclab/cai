# Christopher L. Simons, 2013

ci_pcor <- function(x, y, z, cor_method="pearson") {
    resid_xz <- residuals(lm(formula = x ~ z, data = cbind(x, z)))
    resid_yz <- residuals(lm(formula = y ~ z, data = cbind(y, z)))
    return (cor(x = resid_xz,
                y = resid_yz,
                use="complete.obs",
                method=method_cor))
}

ci_pcor.test <- function(x, y, z, threshold_dep=0.5, cor_method="pearson") {
    return (abs(ci_pcor(x, y, z, cor_method)) >= threshold_dep)
}

# Christopher L. Simons, 2013

ci_pcor <- function(x, y, z, cor_method="pearson", alpha=0.05) {
    resid_xz <- residuals(lm(formula = x ~ z, data = cbind(x, z)))
    resid_yz <- residuals(lm(formula = y ~ z, data = cbind(y, z)))
    return (cor(x = resid_xz,
                y = resid_yz,
                use="complete.obs",
                method=method_cor))
}

# Christopher L. Simons, 2013

ci_pcor <- function(x, y, z, method_cor="pearson") {
    data_subset <- data.frame(cbind(x, y, z))
    names(data_subset) <- c("x", "y", "z")

    resid_xz <- residuals(lm(formula = x ~ z, data = data_subset))
    resid_yz <- residuals(lm(formula = y ~ z, data = data_subset))
    return (cor(x      = resid_xz,
                y      = resid_yz,
                use    = "complete.obs",
                method = method_cor))
}

ci_pcor.test <- function(x, y, z, threshold_dep=0.05, cor_method="pearson") {
    return (abs(ci_pcor(x, y, z, cor_method)) >= threshold_dep)
}

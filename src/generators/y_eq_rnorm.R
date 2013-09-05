# Christopher L. Simons, 2013

for (i in 1:length(VAI__GEN_MODS)) {
    VAI__GEN_MOD = VAI__GEN_MODS[i]
    generator <- list(name = paste("y_eq_rnorm__MOD_",
                                   VAI__GEN_MOD, sep=""),
                      dependent = FALSE,
                      modifiable = TRUE,
                      generate = function(n) {
            x <- rnorm(n, 0, 1 * VAI__GEN_MOD)
            y <- rnorm(n, 0, 1 * VAI__GEN_MOD)
            return (cbind(x, y))
        }
    )
    class(generator) <- "generator"
    generators[[length(generators) + 1]] <- generator
}
VAI__GEN_MOD = VAI__GEN_MOD_DEFAULT

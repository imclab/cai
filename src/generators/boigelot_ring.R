# Christopher L. Simons, 2013

for (i in 1:length(VAI__GEN_MODS)) {
    VAI__GEN_MOD = VAI__GEN_MODS[i]
    generator <- list(name = paste("boigelot_ring[",
                                   VAI__GEN_MOD, "]", sep=""),
                      dependent = TRUE,
                      modifiable = TRUE,
                      generate = function(n) {
            x = runif(n, -1, 1)
            y = cos(x*pi) + rnorm(n, 0, (1/8) * VAI__GEN_MOD)
            x = sin(x*pi) + rnorm(n, 0, (1/8) * VAI__GEN_MOD)
            return (cbind(x, y))
        }
    )
    class(generator) <- "generator"
    generators[[length(generators) + 1]] <- generator
}
VAI__GEN_MOD = VAI__GEN_MOD_DEFAULT

# Christopher L. Simons, 2013

generator <- list(name = paste("\\noise_11::",
                               CAI__GEN_MOD, sep=""),
                  dependent = FALSE,
                  modifiable = TRUE,
                  generate = function(n) {
        x <- rnorm(n, 0, 1 * CAI__GEN_MOD)
        y <- 0 + rnorm(n, 0, 1 * CAI__GEN_MOD)
        return (cbind(x, y))
    }
)
class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

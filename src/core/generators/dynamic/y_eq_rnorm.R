# Christopher L. Simons, 2013

generator <- list(name = paste("y_eq_rnorm::",
                               CAI__GEN_MOD, sep=""),
                  dependent = FALSE,
                  modifiable = TRUE,
                  generate = function(n) {
        x <- rnorm(n, 0, 1 * CAI__GEN_MOD)
        y <- rnorm(n, 0, 1 * CAI__GEN_MOD)
        return (cbind(x, y))
    }
)
class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

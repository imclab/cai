# Christopher L. Simons, 2013

generator <- list(name = paste("y_eq_x+rnorm::",
                               VAI__GEN_MOD, sep=""),
                  dependent = TRUE,
                  modifiable = TRUE,
                  generate = function(n) {
        x <- rnorm(n, 0, 1 * VAI__GEN_MOD)
        y <- x + rnorm(n, 0, 1 * VAI__GEN_MOD)
        return (cbind(x, y))
    }
)
class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

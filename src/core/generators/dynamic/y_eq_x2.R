# Christopher L. Simons, 2013

generator <- list(name = paste("y_eq_x2::",
                               CAI__GEN_MOD, sep=""),
                  dependent = TRUE,
                  modifiable = TRUE,
                  generate = function(n) {
        x <- rnorm(n, 0, 1 * CAI__GEN_MOD)
        y <- x^2
        return (cbind(x, y))
    }
)
class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

# Christopher L. Simons, 2013

generator <- list(name = paste("\\beta(1, 3)::",
                               CAI__GEN_MOD, sep=""),
                  dependent = FALSE,
                  modifiable = TRUE,
                  generate = function(n) {
        x <- rnorm(n, 0, 1 * CAI__GEN_MOD)
        y <- rbeta(n, 1, 3)
        return (cbind(x, y))
    }
)
class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

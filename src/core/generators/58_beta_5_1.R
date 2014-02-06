# Christopher L. Simons, 2013

generator <- list(name = "\\beta(5, 1)",
                  dependent = FALSE,
                  modifiable = TRUE,
                  generate = function(n) {
        x <- rnorm(n, 0, 1)
        y <- rbeta(n, 5, 1)
        return (cbind(x, y))
    }
)
class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

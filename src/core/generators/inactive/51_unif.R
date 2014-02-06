# Christopher L. Simons, 2013

generator <- list(name = "\\unoise",
                  dependent = FALSE,
                  modifiable = TRUE,
                  generate = function(n) {
        x <- rnorm(n, 0, 1)
        y <- runif(n, 0, 1)
        return (cbind(x, y))
    }
)
class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

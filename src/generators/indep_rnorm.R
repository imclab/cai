# Christopher L. Simons, 2013

generator <- list(name = "indep_rnorm", generate = function(n) {
        x <- rnorm(n)
        y <- rnorm(n)
        return (cbind(x, y))
    }
)

class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

# Christopher L. Simons, 2013

generator <- list(name = "max_indep", generate = function(n) {
        x <- rnorm(n)
        y <- rnorm(n)
        return (cbind(x, y))
    }
)

class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator
gen_max_independence <- generator

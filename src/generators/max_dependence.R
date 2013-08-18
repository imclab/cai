# Christopher L. Simons, 2013

generator <- list(name = "max_depend", generate = function(n) {
        x <- rnorm(n)
        y <- x
        return (cbind(x, y))
    }
)

class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator
gen_max_dependence <- generator

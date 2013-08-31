# Christopher L. Simons, 2013

generator <- list(name = "rnorm_y_eq_x", generate = function(n) {
        x <- rnorm(n)
        y <- x
        return (cbind(x, y))
    }
)

class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

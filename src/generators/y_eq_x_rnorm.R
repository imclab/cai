# Christopher L. Simons, 2013

generator <- list(name = "y_eq_x_rnorm",
                  dependent = TRUE,
                  generate = function(n) {
        x <- rnorm(n)
        y <- x * rnorm(n)
        return (cbind(x, y))
    }
)

class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

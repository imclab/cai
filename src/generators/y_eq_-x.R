# Christopher L. Simons, 2013

generator <- list(name = "y_eq_-x",
                  dependent = TRUE,
                  generate = function(n) {
        x <- rnorm(n)
        y <-  x * (-1)
        return (cbind(x, y))
    }
)

class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

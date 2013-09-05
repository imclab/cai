# Christopher L. Simons, 2013

generator <- list(name = "boigelot_ring",
                  dependent = TRUE,
                  generate = function(n) {
        x = runif(n, -1, 1)
        y = cos(x*pi) + rnorm(n, 0, 1/8)
        x = sin(x*pi) + rnorm(n, 0, 1/8)
        return (cbind(x, y))
    }
)

class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

# Christopher L. Simons, 2013

generator <- list(name = "boigelot_ex", generate = function(n) {
        x = runif(n, -1, 1)
        y = (x^2 + runif(n, 0, 1/2)) * sample(seq(-1, 1, 2), n, replace = TRUE)
        return (cbind(x, y))
    }
)

class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

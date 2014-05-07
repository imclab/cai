# Copyright 2013, 2014 by Christopher L. Simons

generator <- list(name       = "x/100",
                  dependent  = TRUE,
                  modifiable = TRUE,
                  generate   = function(n)
{
    x <- rnorm(n, 0, 1)
    y <- (x/100) + rnorm(n, 0, 1)
    return (cbind(x, y))
})
class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

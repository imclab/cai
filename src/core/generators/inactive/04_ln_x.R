# Copyright 2013, 2014 by Christopher L. Simons

generator <- list(name       = "ln |x|",
                  dependent  = TRUE,
                  modifiable = TRUE,
                  generate   = function(n)
{
    x <- rnorm(n, 0, 1)
    y <- log(abs(x)) + rnorm(n, 0, 1)
    return (cbind(x, y))
})
class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

# Copyright 2013, 2014 by Christopher L. Simons

generator <- list(name       = "\\beta(1, 3)",
                  dependent  = FALSE,
                  modifiable = TRUE,
                  generate   = function(n)
{
    x <- rnorm(n, 0, 1)
    y <- rbeta(n, 1, 3)
    return (cbind(x, y))
})
class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

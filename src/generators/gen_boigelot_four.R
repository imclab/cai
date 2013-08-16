# Christopher L. Simons, 2013

library(mvtnorm)

generator <- list(name = "boigelot_four", generate = function(n) {
        xy1 = rmvnorm(n/4, c( 3,  3))
        xy2 = rmvnorm(n/4, c(-3,  3))
        xy3 = rmvnorm(n/4, c(-3, -3))
        xy4 = rmvnorm(n/4, c( 3, -3))
        return(rbind(xy1, xy2, xy3, xy4))
    }
)

class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

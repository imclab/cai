# Christopher L. Simons, 2013

library(mvtnorm)

gen_boigelot_four <- list(generate = function(n) {
        xy1 = rmvnorm(n/4, c( 3,  3))
        xy2 = rmvnorm(n/4, c(-3,  3))
        xy3 = rmvnorm(n/4, c(-3, -3))
        xy4 = rmvnorm(n/4, c( 3, -3))
        return(rbind(xy1, xy2, xy3, xy4))
    }
)

class(gen_boigelot_four) <- "generator"

# Christopher L. Simons, 2013

gen_boigelot_ring <- list(generate = function(n) {
        x = runif(n, -1, 1)
        y = cos(x*pi) + rnorm(n, 0, 1/8)
        x = sin(x*pi) + rnorm(n, 0, 1/8)
        return (cbind(x, y))
    }
)

class(gen_boigelot_ring) <- "generator"

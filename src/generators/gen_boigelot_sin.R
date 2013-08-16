# Christopher L. Simons, 2013

gen_boigelot_sin <- list(generate = function(n) {
        x = runif(n, -1, 1)
        y = 4 * (x^2 - 1/2)^2 + runif(n, -1, 1)/3
        return (cbind(x, y))
    }
)

class(gen_boigelot_sin) <- "generator"

generators <- append(generators, gen_boigelot_sin)

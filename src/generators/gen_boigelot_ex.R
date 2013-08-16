# Christopher L. Simons, 2013

gen_boigelot_ex <- list(generate = function(n) {
        x = runif(n, -1, 1)
        y = (x^2 + runif(n, 0, 1/2)) * sample(seq(-1, 1, 2), n, replace = TRUE)
        return (cbind(x, y))
    }
)

class(gen_boigelot_ex) <- "generator"

generators <- append(generators, gen_boigelot_ex)

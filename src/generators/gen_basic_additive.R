# Christopher L. Simons, 2013

gen_basic_additive <- list(
    generate <- function(n) {
        x <- rnorm(n)
        y <- x + rnorm(n)
        return (cbind(x, y))
    }
)

class(gen_basic_additive) <- "generator"

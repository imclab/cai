# Christopher L. Simons, 2013

generator <- list(name = paste("boigelot_sin::",
                               CAI__GEN_MOD, sep=""),
                  dependent = TRUE,
                  modifiable = FALSE,
                  generate = function(n) {
        x = runif(n, -1, 1)
        y = 4 * (x^2 - 1/2)^2 + runif(n, -1, 1)/3
        return (cbind(x, y))
    }
)
class(generator) <- "generator"
generators[[length(generators) + 1]] <- generator

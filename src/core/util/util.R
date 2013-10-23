# Christopher L. Simons, 2013

nformat <- function(n) {
    return (sprintf("%8.3f", n))
}

p <- function(...) {
    cat(..., "\n", sep="")
}

pn <- function(...) {
    cat(..., sep="")
}

p_matrix <- function(x) {
    write(x, sep="\t", ncolumns=length(x[,1]), file="")
}

interval_scale <- function(x, a = 0, b = 1) {
    # To [0, 1]:
    #
    #         x - min
    # f(x) = ---------
    #        max - min
    #
    # To [a, b]:
    #
    #        (b-a)(x - min)
    # f(x) = --------------  +  a
    #          max - min
    #
    return ((((b - a) * (x - min(x)))
             / (max(x) - min(x))) + a)
}

bin_count_fixed <- function(n) {
    return (break.fixed.n);
}

# (Sturges, 1926)
bin_count_sturges <- function(n) {
    return (ceiling(1 + log2(n)))
}

break_methods = list(fixed   = bin_count_fixed,
                     sturges = bin_count_sturges)

bin_count <- function(n) {
    return (break_methods[[break_method]](n))
}

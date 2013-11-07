# Christopher L. Simons, 2013

nvl <- function (a, b) {
    return (if (is.null(a)) b else a)
}

navl <- function (a, b) {
    return (if (is.na(a)) b else a)
}

nformat <- function(n) {
    if (is.numeric(n))
        return (sprintf("%.3f", n))
    else
        return (n)
}

p <- function(...) {
    cat(..., "\n", sep="")
}

pn <- function(...) {
    cat(..., sep="")
}

verbose <- function(...) {
    if (param.verbose)
        p(...)
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

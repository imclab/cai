# Christopher L. Simons, 2013

nformat <- function(n) {
    return (sprintf("%8.3f", n))
}

p <- function(...) {
    cat(..., "\n", sep="")
}

p_matrix <- function(x) {
    write(x, sep="\t", ncolumns=length(x[,1]), file="")
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

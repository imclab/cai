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

# (Sturges, 1926)
bin_count_sturge <- function(n) {
    return (ceiling(1 + log2(n)))
}

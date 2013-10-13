# Christopher L. Simons, 2013

# Provide break points to establish n discretization bins of equal width.
breaks_uniform_width <- function(data, n_bins) {
    vec_min <- min(data)
    vec_max <- max(data)
    span <- vec_max - vec_min
    bin_width <- span / n_bins

    breakpoints <- c(vec_min)
    while (length(breakpoints) <= n_bins) {
        next_break <- vec_min + (length(breakpoints) * bin_width)
        breakpoints[length(breakpoints) + 1] <- next_break
    }
    return (breakpoints)
}

# Provide break points to establish n discretization bins of equal data points.
breaks_uniform_counts <- function(data, n_bins) {
    bin_count <- length(data) / n_bins
    sorted_data <- sort(data)
    vec_min <- sorted_data[1]

    breakpoints <- c(vec_min)
    while (length(breakpoints) <= n_bins) {
        next_break <- sorted_data[length(breakpoints) * bin_count]
        breakpoints[length(breakpoints) + 1] <- next_break
    }
    return (breakpoints)
}

# Sturges's method (see Margaritis, 2005).
breaks_dyn_sturges <- function(data) {
    # TODO: k = 1 + log_2(N) bins of equal width.
}

# Scott's method (see Margaritis, 2005).
breaks_dyn_scott <- function(data) {
    # TODO:
    # Optimal bin width: h = 3.5sN^(-1/(2+d)),
    # where s is sample standard deviation,
    # and d is number of dimensions.
}

# Freedman and Diaconis's method (see Margaritis, 2005).
breaks_dyn_freedman_diaconis <- function(data) {
    # TODO:
    # Optimal bin width: h = 2(IQ)N^(-1/(2+d)),
    # where IQ is interquartile range.
}

# Christopher L. Simons, 2013

# Provide break points to establish n discretization bins of equal width.
breaks_uniform_width <- function(data, n_bins) {
    vec_min <- min(data)
    vec_max <- max(data)
    span <- vec_max - vec_min
    bin_width <- span / n_bins

    breakpoints <- c(vec_min)
    while (length(breakpoints) < n_bins) {
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
    while (length(breakpoints) < n_bins) {
        next_break <- sorted_data[length(breakpoints) * bin_count]
        breakpoints[length(breakpoints) + 1] <- next_break
    }
    return (breakpoints)
}

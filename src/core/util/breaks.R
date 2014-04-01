# Christopher L. Simons, 2013

# Provide break points to establish n bins of equal width.
breaksUniformWidth <- function(data, n.bins)
{
    vec.min <- min(data)
    vec.max <- max(data)
    span <- vec.max - vec.min
    bin.width <- span / n.bins

    breakpoints <- c(vec.min)
    while (length(breakpoints) <= n.bins)
    {
        next.break <- vec.min + (length(breakpoints) * bin.width)
        breakpoints[length(breakpoints) + 1] <- next.break
    }
    return (breakpoints)
}

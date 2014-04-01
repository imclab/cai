# Christopher L. Simons, 2013

nvl <- function (a, b)
{
    return (if (is.null(a)) b else a)
}

navl <- function (a, b)
{
    return (if (is.na(a)) b else a)
}

nformat <- function(n)
{
    if (is.numeric(n))
        return (sprintf("%.2f", n))
    else
        return (n)
}

p <- function(...)
{
    cat(..., "\n", sep="")
}

pn <- function(...)
{
    cat(..., sep="")
}

verbose <- function(...)
{
    if (param.verbose)
        p(...)
}

pMatrix <- function(x)
{
    write(x, sep="\t", ncolumns=length(x[,1]), file="")
}

intervalScale <- function(x, a = 0, b = 1)
{
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

iqrReduce <- function(data)
{
    # Reduce 'data' to inner-quartile range per X-axis.

    x <- data[,1]
    idx.25 <- floor(length(x) / 4)
    idx.75 <- ceiling((length(x) / 4) * 3)
    x.sorted <- sort(x)
    iqr.a <- x.sorted[idx.25]
    iqr.b <- x.sorted[idx.75]

    reduced.data <- NULL
    for (i in 1:length(data[,1]))
    {
        xi <- data[i,1]
        yi <- data[i,2]
        if (xi >= iqr.a && xi <= iqr.b)
            reduced.data <- rbind(reduced.data, cbind(xi, yi))
    }

    return (reduced.data)
}

binCount <- function(n)
{
    return (ceiling(1 + log2(n))) # (Sturges, 1926)
}

# Provide break points to establish n bins of equal width.
breaksUniformWidth <- function(data, n.bins, preSorted=FALSE)
{
    if (preSorted) {
        vec.min <- data[1]
        vec.max <- data[length(data)]
    } else {
        vec.min <- min(data)
        vec.max <- max(data)
    }

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

# From http://stackoverflow.com/questions/2547402/
#          standard-library-function-in-r-for-finding-the-mode
Mode <- function(x)
{
    ux <- unique(x)
    ux[which.max(tabulate(match(x, ux)))]
}

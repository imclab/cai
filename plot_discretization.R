# Christopher L. Simons, 2013

within <- function(x, lower, upper) {
    return((x > lower) && (x < upper))
}

a <- rnorm(1000)
b <- a + rnorm(1000)

breaks_a <- hist(a, plot=FALSE)$breaks
breaks_b <- hist(b, plot=FALSE)$breaks

bins_a <- list()
for (i in 1:(length(breaks_a) - 1)) { # for each bin number ...
    bin_current <- c()
    for (j in 1:length(a)) { # for each data point number ...
        if (within(a[j], breaks_a[i], breaks_a[i + 1])) { # if within bin range
            bin_current[(length(bin_current) + 1)] <- a[j]
        }
    }
    bins_a[[i]] <- bin_current
}

bins_b <- list()
for (i in 1:(length(breaks_b) - 1)) { # for each bin number ...
    bin_current <- c()
    for (j in 1:length(b)) { # for each data point number ...
        if (within(b[j], breaks_b[i], breaks_b[i + 1])) { # if within bin range
            bin_current[(length(bin_current) + 1)] <- b[j]
        }
    }
    bins_b[[i]] <- bin_current
}

plot(a, b)

# Plot bins for vector a (plotted against x-axis).
for (i in 1:(length(breaks_a) - 1)) {
    coords_x <- c()
    coords_x[length(coords_x) + 1] <- breaks_a[i]
    coords_x[length(coords_x) + 1] <- breaks_a[i]
    coords_x[length(coords_x) + 1] <- breaks_a[i + 1]
    coords_x[length(coords_x) + 1] <- breaks_a[i + 1]
    coords_x[length(coords_x) + 1] <- breaks_a[i]

    coords_y <- c()
    coords_y[length(coords_y) + 1] <- min(b) # "zero" for our plot
    coords_y[length(coords_y) + 1] <- max(b)
    coords_y[length(coords_y) + 1] <- max(b)
    coords_y[length(coords_y) + 1] <- min(b)
    coords_y[length(coords_y) + 1] <- min(b)

    polygon(coords_x, coords_y)
}

# Plot bins for vector b (plotted against y-axis).
for (i in 1:(length(breaks_b) - 1)) {
    coords_x <- c()
    coords_x[length(coords_x) + 1] <- min(a) # "zero" for our plot
    coords_x[length(coords_x) + 1] <- max(a)
    coords_x[length(coords_x) + 1] <- max(a)
    coords_x[length(coords_x) + 1] <- min(a)
    coords_x[length(coords_x) + 1] <- min(a)

    coords_y <- c()
    coords_y[length(coords_y) + 1] <- breaks_b[i]
    coords_y[length(coords_y) + 1] <- breaks_b[i]
    coords_y[length(coords_y) + 1] <- breaks_b[i + 1]
    coords_y[length(coords_y) + 1] <- breaks_b[i + 1]
    coords_y[length(coords_y) + 1] <- breaks_b[i]

    polygon(coords_x, coords_y)
}

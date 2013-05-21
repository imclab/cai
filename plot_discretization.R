# Christopher L. Simons, 2013

n_points <- 1000

#png("test.png")

within <- function(x, lower, upper) {
    return((x > lower) && (x < upper))
}

a <- rnorm(n_points)
b <- a + rnorm(n_points)

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

for (i in 1:(length(breaks_a) - 1)) {
    for (j in 1:(length(breaks_b) - 1)) {
        # Polygon for each cell =
        # { (lo-i, lo-j), (up-i, lo-j),
        #   (up-i, up-j), (lo-i, up-j), (lo-i, lo-j) }
        coords_x <- c()
        coords_x[length(coords_x) + 1] <- breaks_a[i]
        coords_x[length(coords_x) + 1] <- breaks_a[i + 1]
        coords_x[length(coords_x) + 1] <- breaks_a[i + 1]
        coords_x[length(coords_x) + 1] <- breaks_a[i]
        coords_x[length(coords_x) + 1] <- breaks_a[i]
        coords_y <- c()
        coords_y[length(coords_y) + 1] <- breaks_b[j]
        coords_y[length(coords_y) + 1] <- breaks_b[j]
        coords_y[length(coords_y) + 1] <- breaks_b[j + 1]
        coords_y[length(coords_y) + 1] <- breaks_b[j + 1]
        coords_y[length(coords_y) + 1] <- breaks_b[j]
        polygon(coords_x, coords_y)
    }
}

#dev.off()

#
# Christopher L. Simons, 2013
#

a <- rnorm(1000)
b <- a + rnorm(1000)

breaks_a <- hist(a, plot=FALSE)$breaks
breaks_b <- hist(b, plot=FALSE)$breaks

within <- function(x, lower, upper) {
    return((x > lower) && (x < upper))
}

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
print(bins_a)

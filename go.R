# Christopher L. Simons, 2013

source("plot_disc.R")

n_points <- 1000

x <- rnorm(n_points)
y <- x + rnorm(n_points)
data <- cbind(y, x)

z <- disc_plot(data, showPlot=FALSE)
z <- round(z, digits=2) * 100

print(z)

#for (i in 1:length(z[1,])) { # for each row
for (i in 5:6) { # DEBUGGING
    width <- length(z[i,])
    center <- floor(width / 2) # ignore center for odd column cardinalities.
    results <- c()
    print(cat("width:", width, "\t\t"))
    print(cat("center:", center, "\t\t"))
    for (j in 1:center) {
        left <- z[i,j]
        right <- z[i, width - (j - 1)]
        results <- append(results, left == right)
        print(cat("comparing: (", left, "==", right, ") ->", results, "\t"))
    }
    print(results)
}

# Christopher L. Simons, 2013

source("assess_stat.R")

n_points <- 1000

x <- rnorm(n_points)
y <- x + rnorm(n_points)
data <- cbind(y, x)

alpha <- 0.2
z <- build_plot_matrix(data)
print(round(z * 100))

print(cat("Overall assessment: existsDependency =", existsDependency(data)))

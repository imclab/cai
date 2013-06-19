# Christopher L. Simons, 2013

source("src/assess_stat.R")

n_points <- 1000

x <- rnorm(n_points)
y <- x + rnorm(n_points)
#y <- rnorm(n_points)
data <- cbind(y, x)

alpha <- 0.2
z <- build_plot_matrix(data)
print(round(z * 100))

alpha_mean <- 1.0
alpha_var  <- 1.0

obj <- existsDependency(data, alpha_mean, alpha_var)
print(cat("x-independence:", obj$independent_x))
print(cat("y-independence:", obj$independent_y))
print("Result object stored in obj.")

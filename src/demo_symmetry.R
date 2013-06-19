# Christopher L. Simons, 2013

source("src/assess_sym.R")

n_points <- 1000

x <- rnorm(n_points)
y <- x + rnorm(n_points)
data <- cbind(y, x)

alpha <- 0.2
z <- build_plot_matrix(data)
print(round(z * 100))

n <- length(z[,1]) # count first column to find number of rows
print(cat("using alpha-level:", alpha))
for (i in 1:n) {
    row <- z[i,]
    print(cat(i, ": row is symmetric (", diffSymmetric(row),
              "<", alpha, ")?: ", isRowSymmetric(z[i,], alpha)))
}

print(cat("Overall assessment: isSymmetric =", isSymmetric(data, alpha)))

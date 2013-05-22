# Christopher L. Simons, 2013

source("plot_discretization.R")

n_points <- 1000

x <- rnorm(n_points)
y <- x + rnorm(n_points)
data <- cbind(x, y)

png("plot_bins.png")
disc_plot(data, color=FALSE)
dev.off()

png("plot_color.png")
disc_plot(data, color=TRUE, debug=TRUE)
dev.off()

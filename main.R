# Christopher L. Simons, 2013

source("plot_disc.R")
#source("rand_distributions.R")

n_points <- 5000

x <- rnorm(n_points)
y <- x + rnorm(n_points)
data <- cbind(x, y)

png("plot_0_grid.png")
disc_plot(data, fill=FALSE)
dev.off()

png("plot_1_fill.png")
disc_plot(data, fill=TRUE, gradient=FALSE, debug=TRUE)
dev.off()

png("plot_2_gradient.png")
disc_plot(data, fill=TRUE, gradient=TRUE, debug=TRUE)
dev.off()

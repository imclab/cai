# Christopher L. Simons, 2013

source("src/plot_disc.R")

n_points <- 5000

x <- rnorm(n_points)
y <- x + rnorm(n_points)
data <- cbind(x, y)

png("plot_0_grid.png")
plot_disc(data, fill=FALSE)
dev.off()

png("plot_1_fill.png")
plot_disc(data, fill=TRUE, gradient=FALSE, debug=TRUE)
dev.off()

png("plot_2_gradient.png")
plot_disc(data, fill=TRUE, gradient=TRUE, debug=TRUE)
dev.off()

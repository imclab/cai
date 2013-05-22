# Christopher L. Simons, 2013

n_points <- 1000

#png("test.png")

x <- rnorm(n_points)
y <- x + rnorm(n_points)
data <- cbind(x, y)

breaks_x <- hist(x, plot=FALSE)$breaks
breaks_y <- hist(y, plot=FALSE)$breaks

debug_flag <- TRUE
debug <- function(message) {
    if (debug_flag) {
        print(message)
    }
}

plot(data)

cell_points <- c()
for (xb in 1:(length(breaks_x) - 1)) {
    for (yb in 1:(length(breaks_y) - 1)) {
        points_in_cell <- 0
        for (i in 1:length(data[,1])) {
            xi <- data[i,][1]
            yi <- data[i,][2]
            if (xi >= breaks_x[xb] && xi <= breaks_x[xb + 1]
                    && yi >= breaks_y[yb] && yi <= breaks_y[yb + 1]) {
                points_in_cell <- points_in_cell + 1
            }
        }
        cell_points[length(cell_points) + 1] <- points_in_cell
        #
        # Draw polygon for each cell; verticies:
        # { (lo-px, lo-py), (hi-px, lo-py),
        #   (hi-px, hi-py), (lo-px, hi-py), (lo-px, lo-py) }
        #
        coords_x <- c()
        coords_x[length(coords_x) + 1] <- breaks_x[xb]
        coords_x[length(coords_x) + 1] <- breaks_x[xb + 1]
        coords_x[length(coords_x) + 1] <- breaks_x[xb + 1]
        coords_x[length(coords_x) + 1] <- breaks_x[xb]
        coords_x[length(coords_x) + 1] <- breaks_x[xb]

        coords_y <- c()
        coords_y[length(coords_y) + 1] <- breaks_y[yb]
        coords_y[length(coords_y) + 1] <- breaks_y[yb]
        coords_y[length(coords_y) + 1] <- breaks_y[yb + 1]
        coords_y[length(coords_y) + 1] <- breaks_y[yb + 1]
        coords_y[length(coords_y) + 1] <- breaks_y[yb]

        polygon(coords_x, coords_y)
    }
}

print(cell_points)
#dev.off()

# Christopher L. Simons, 2013

disc_plot <- function(data, color=FALSE, debug=FALSE) {
    x <- data[,1]
    y <- data[,2]

    breaks_x <- hist(x, plot=FALSE)$breaks
    breaks_y <- hist(y, plot=FALSE)$breaks

    plot(data)

    cell_points <- c()
    cell_weights <- c()
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
            cell_weight <- points_in_cell / n_points
            cell_points[length(cell_points) + 1] <- points_in_cell
            cell_weights[length(cell_weights) + 1] <- cell_weight
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

            if (color) {
                if (cell_weight > 0) {
                    polygon(coords_x, coords_y, col="gray")
                } else {
                    polygon(coords_x, coords_y, col="white")
                }
            } else {
                polygon(coords_x, coords_y)
            }
        }
    }

    if (debug) {
        print(cell_weights)
    }
}

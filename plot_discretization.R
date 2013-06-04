# Christopher L. Simons, 2013

build_discretized_struct <- function(data) {
    x <- data[,1]
    y <- data[,2]

    breaks_x <- hist(x, plot=FALSE)$breaks
    breaks_y <- hist(y, plot=FALSE)$breaks

    bins <- list()
    max_cell_points <- 0
    for (xb in 1:(length(breaks_x) - 1)) {
        for (yb in 1:(length(breaks_y) - 1)) {
            cell_points <- 0
            for (i in 1:length(data[,1])) {
                xi <- data[i,][1]
                yi <- data[i,][2]
                if (xi >= breaks_x[xb] && xi <= breaks_x[xb + 1]
                        && yi >= breaks_y[yb] && yi <= breaks_y[yb + 1]) {
                    cell_points <- cell_points + 1
                }
            }

            if (max_cell_points < cell_points) max_cell_points <- cell_points

            # Polygon coordinates for each cell.
            coords_x <- c()
            coords_x <- append(coords_x, breaks_x[xb])
            coords_x <- append(coords_x, breaks_x[xb + 1])
            coords_x <- append(coords_x, breaks_x[xb + 1])
            coords_x <- append(coords_x, breaks_x[xb])
            coords_x <- append(coords_x, breaks_x[xb])

            coords_y <- c()
            coords_y <- append(coords_y, breaks_y[yb])
            coords_y <- append(coords_y, breaks_y[yb])
            coords_y <- append(coords_y, breaks_y[yb + 1])
            coords_y <- append(coords_y, breaks_y[yb + 1])
            coords_y <- append(coords_y, breaks_y[yb])

            nBin <- length(bins) + 1
            bins[[nBin]] <- list("cell_points"=cell_points,
                                 "coords_x"=coords_x,
                                 "coords_y"=coords_y)
        }
    }
    bins[["max_cell_points"]] <- max_cell_points
    return(bins)
}

weightShade <- function(cell_weight) {
    reversed <- (1 - cell_weight)
    return(rgb(reversed, reversed, reversed))
}

cellColor <- function(fill, gradient, cell_weight) {
    if (fill) {
        if (cell_weight > 0) {
            if (gradient) {
                return(weightShade(cell_weight))
            } else {
                return(rgb(0, 0, 0))
            }
        } else {
            return("white")
        }
    } else {
        return(NA)
    }
}

disc_plot <- function(data,
                        showPlot=TRUE,
                        fill=TRUE,
                        gradient=TRUE,
                        debug=FALSE) {
    bins <- build_discretized_struct(data)

    if (showPlot) plot(data)

    for (i in 1:length(bins)) {
        coords_x <- bins[[i]]$coords_x
        coords_y <- bins[[i]]$coords_y

        cell_weight <- bins[[i]]$cell_points / bins$max_cell_points
        if (showPlot) {
            polygon(coords_x, coords_y, col=cellColor(fill,
                                                      gradient,
                                                      cell_weight))
        }
    }
}

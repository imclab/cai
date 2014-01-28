# Christopher L. Simons, 2013

source("src/core/util/breaks.R")

build_discretized_struct <- function(data) {
    x <- data[,1]
    y <- data[,2]

    breaks_x <- breaks_uniform_width(x, bin_count(nrow(data)))
    breaks_y <- breaks_uniform_width(y, bin_count(nrow(data)))

    agg_coords_x <- c()
    agg_coords_y <- c()
    max_cell_points <- 0
    agg_cell_points <- c()
    for (xb in 1:(length(breaks_x) - 1)) {
        for (yb in 1:(length(breaks_y) - 1)) {
            data_df <- data.frame(data)
            names(data_df) <- c("x", "y")
            cell_points <- length(subset(data,
                                         subset = (  x >= breaks_x[xb]
                                                   & x <= breaks_x[xb + 1]
                                                   & y >= breaks_y[yb]
                                                   & y <= breaks_y[yb + 1])))
            if (max_cell_points < cell_points)
                max_cell_points <- cell_points

            # Polygon coordinates for each cell.
            xba <- breaks_x[xb]
            xbb <- breaks_x[xb + 1]
            yba <- breaks_y[yb]
            ybb <- breaks_y[yb + 1]
            agg_coords_x <- append(agg_coords_x, c(xba, xbb, xbb, xba, xba))
            agg_coords_y <- append(agg_coords_y, c(yba, yba, ybb, ybb, yba))
            agg_cell_points <- append(agg_cell_points, cell_points)
        }
    }
    agg_max_cell_points <- max_cell_points

    obj <- list("ncol"            = (length(breaks_x) - 1),
                "nrow"            = (length(breaks_y) - 1),
                "coords_x"        = matrix(agg_coords_x, ncol=5, byrow=TRUE),
                "coords_y"        = matrix(agg_coords_y, ncol=5, byrow=TRUE),
                "cell_points"     = agg_cell_points,
                "max_cell_points" = agg_max_cell_points)
    return(obj)
}

weightShade <- function(cell_weight) {
    reversed <- (1 - cell_weight)
    return(rgb(reversed, reversed, reversed))
}

cellColor <- function(fill, gradient, cell_weight) {
    if (!fill)
        return (NA)
    else {
        if (cell_weight <= 0)
            return ("white")
        else {
            if (gradient) {
                return(weightShade(cell_weight))
            } else {
                return(rgb(0, 0, 0))
            }
        }
    }
}

plot_disc <- function(data,
                      filename=NULL,
                      fill=TRUE,
                      gradient=TRUE,
                      debug=FALSE) {
    disc_struct <- build_discretized_struct(data)
    coords_x <- disc_struct$coords_x
    coords_y <- disc_struct$coords_y
    cell_points <- disc_struct$cell_points
    max_cell_points <- disc_struct$max_cell_points

    n_cells <- length(cell_points)

    if (!is.null(filename)) {
        png(filename)
    }
    plot(data)
    for (i in 1:n_cells) {
        cell_weight <- cell_points[i] / max_cell_points
        polygon(coords_x[i,], coords_y[i,],
                col=cellColor(fill, gradient, cell_weight))
    }
    if (!is.null(filename)) {
        dev.off()
    }
}

build_plot_matrix <- function(data) {
    disc_struct <- build_discretized_struct(data)
    cell_points <- disc_struct$cell_points
    max_cell_points <- disc_struct$max_cell_points

    n_cells <- length(cell_points)

    vec_weights <- c()
    for (i in 1:n_cells) {
        cell_weight <- cell_points[i] / max_cell_points
        vec_weights <- append(vec_weights, cell_weight)
    }

    matrix_weights <- matrix(vec_weights, nrow=disc_struct$nrow)
    matrix_weights <- matrix_weights[disc_struct$nrow:1,]

    return(matrix_weights)
}

print_weight_matrix <- function(data) {
    z <- build_plot_matrix(data)
    p_matrix(round(z * 100))
}

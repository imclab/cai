# Christopher L. Simons, 2013

source("plot_disc.R")

existsDependency <- function(data) {
    x <- data[,1]
    y <- data[,2]

    breaks_x <- hist(x, plot=FALSE)$breaks
    breaks_y <- hist(y, plot=FALSE)$breaks

    x_values <- c()
    for (xb in 1:(length(breaks_x) - 1)) {
        for (i in 1:length(data[,1])) {
            xi <- data[i,][1]
            if (xi >= breaks_x[xb] && xi <= breaks_x[xb + 1]) {
                x_values <- append(x_values, xi)
            }
        }
    }
    x_val_matrix <- matrix(x_values, ncol=(length(breaks_x) - 1), byrow=TRUE)

    y_values <- c()
    for (yb in 1:(length(breaks_y) - 1)) {
        for (i in 1:length(data[,1])) {
            yi <- data[i,][1]
            if (yi >= breaks_y[yb] && yi <= breaks_y[yb + 1]) {
                y_values <- append(y_values, yi)
            }
        }
    }
    y_val_matrix <- matrix(y_values, ncol=(length(breaks_y) - 1), byrow=TRUE)

    return ("TODO: Finish this.")
}

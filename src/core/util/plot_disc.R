# Christopher L. Simons, 2013

buildDiscretizedStruct <- function(data)
{
    x <- data[,1]
    y <- data[,2]

    breaks.x <- breaksUniformWidth(x, binCount(nrow(data)))
    breaks.y <- breaksUniformWidth(y, binCount(nrow(data)))

    agg.coords.x <- c()
    agg.coords.y <- c()
    max.cell.points <- 0
    agg.cell.points <- c()
    for (xb in 1:(length(breaks.x) - 1))
    {
        for (yb in 1:(length(breaks.y) - 1))
        {
            data.df <- data.frame(data)
            names(data.df) <- c("x", "y")
            cell.points <- length(subset(data,
                                         subset = (  x >= breaks.x[xb]
                                                   & x <= breaks.x[xb + 1]
                                                   & y >= breaks.y[yb]
                                                   & y <= breaks.y[yb + 1])))
            if (max.cell.points < cell.points)
                max.cell.points <- cell.points

            # Polygon coordinates for each cell.
            xba <- breaks.x[xb]
            xbb <- breaks.x[xb + 1]
            yba <- breaks.y[yb]
            ybb <- breaks.y[yb + 1]
            agg.coords.x <- append(agg.coords.x, c(xba, xbb, xbb, xba, xba))
            agg.coords.y <- append(agg.coords.y, c(yba, yba, ybb, ybb, yba))
            agg.cell.points <- append(agg.cell.points, cell.points)
        }
    }
    agg.max.cell.points <- max.cell.points

    obj <- list("ncol"            = (length(breaks.x) - 1),
                "nrow"            = (length(breaks.y) - 1),
                "coords.x"        = matrix(agg.coords.x, ncol=5, byrow=TRUE),
                "coords.y"        = matrix(agg.coords.y, ncol=5, byrow=TRUE),
                "cell.points"     = agg.cell.points,
                "max.cell.points" = agg.max.cell.points)
    return(obj)
}

weightShade <- function(cell.weight)
{
    reversed <- (1 - cell.weight)
    return(rgb(reversed, reversed, reversed))
}

cellColor <- function(fill, gradient, cell.weight)
{
    if (!fill) {
        return (NA)
    } else {
        if (cell.weight <= 0) {
            return ("white")
        } else {
            if (gradient)
                return(weightShade(cell.weight))
            else
                return(rgb(0, 0, 0))
        }
    }
}

plotDisc <- function(data,
                     filename = NULL,
                     fill     = TRUE,
                     gradient = TRUE,
                     debug    = FALSE)
{
    disc.struct <- buildDiscretizedStruct(data)
    coords.x <- disc.struct$coords.x
    coords.y <- disc.struct$coords.y
    cell.points <- disc.struct$cell.points
    max.cell.points <- disc.struct$max.cell.points

    n.cells <- length(cell.points)

    if (!is.null(filename))
        png(filename)

    plot(data)
    for (i in 1:n.cells)
    {
        cell.weight <- cell.points[i] / max.cell.points
        polygon(coords.x[i,], coords.y[i,],
                col=cellColor(fill, gradient, cell.weight))
    }

    if (!is.null(filename))
        dev.off()
}

buildPlotMatrix <- function(data)
{
    disc.struct <- buildDiscretizedStruct(data)
    cell.points <- disc.struct$cell.points
    max.cell.points <- disc.struct$max.cell.points

    n.cells <- length(cell.points)

    vec.weights <- c()
    for (i in 1:n.cells)
    {
        cell.weight <- cell.points[i] / max.cell.points
        vec.weights <- append(vec.weights, cell.weight)
    }

    matrix.weights <- matrix(vec.weights, nrow=disc.struct$nrow)
    matrix.weights <- matrix.weights[disc.struct$nrow:1,]

    return(matrix.weights)
}

printWeightMatrix <- function(data)
{
    z <- buildPlotMatrix(data)
    pMatrix(round(z * 100))
}

printModeMatrix <- function(data, theta)
{
    z <- buildPlotMatrix(data)
    for (i in 1:nrow(z))
        for (j in ncol(z))
            z[i,j] <- if (z[i,j] >= theta) 1 else 0
    pMatrix(round(z * 100))
}

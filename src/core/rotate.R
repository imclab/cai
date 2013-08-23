# Christopher L. Simons, 2013

# Rotates data CLOCKWISE around origin.
rotate <- function(data, theta) {
    sin_t <- sin(theta)
    cos_t <- cos(theta)

    x <- data[,1]
    y <- data[,2]
    ox <- 0 # median(x)
    oy <- 0 # median(y)

    x2 <- c()
    y2 <- c()
    for (i in 1:length(x)) {
        px <- x[i]
        py <- y[i]
        px2 <- cos_t * (px - ox) - sin_t * (py - oy) + ox
        py2 <- sin_t * (px - ox) + cos_t * (py - oy) + oy
        x2 <- append(x2, px2)
        y2 <- append(y2, py2)
    }
    data2 <- cbind(x2, y2)
    return (data2)
}

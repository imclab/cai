#
# Title:    An example of the correlation of x and y
#           for various distributions of (x,y) pairs.
# Author:   Denis Boigelot
# Tags:     Mathematics; Statistics; Correlation
# Requires: mvtnorm (rmvnorm), RSVGTipsDevice (devSVGTips)
# Usage:    output()
#
# This is an translated version in R of an Matematica 6 code by Imagecreator.
#
# RELEASED INTO THE PUBLIC DOMAIN, PER THE FOLLOWING URL:
# http://en.wikipedia.org/wiki/File:Correlation_examples2.svg
#

library(mvtnorm)

MyPlot <- function(xy, xlim = c(-4, 4), ylim = c(-4, 4), eps = 1e-15) {
   title = round(cor(xy[,1], xy[,2]), 1)
   if (sd(xy[,2]) < eps) title = "" # corr. coeff. is undefined
   plot(xy, main = title, xlab = "", ylab = "",
        col = "darkblue", pch = 16, cex = 0.2,
        xaxt = "n", yaxt = "n", bty = "n",
        xlim = xlim, ylim = ylim)
}

gen_boigelot_sin <- list(generate = function(n) {
        x = runif(n, -1, 1)
        y = 4 * (x^2 - 1/2)^2 + runif(n, -1, 1)/3
        #MyPlot(cbind(x,y), xlim = c(-1, 1), ylim = c(-1/3, 1+1/3))
        return (cbind(x, y))
    }
)

class(gen_boigelot_sin) <- "generator"

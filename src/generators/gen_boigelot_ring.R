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

gen_boigelot_ring <- list(generate = function(n) {
        x = runif(n, -1, 1)
        y = cos(x*pi) + rnorm(n, 0, 1/8)
        x = sin(x*pi) + rnorm(n, 0, 1/8)
        #MyPlot(cbind(x,y), xlim = c(-1.5, 1.5), ylim = c(-1.5, 1.5))
        return (cbind(x, y))
    }
)

class(gen_boigelot_ring) <- "generator"

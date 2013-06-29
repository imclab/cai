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

gen_boigelot_four <- list(generate = function(n) {
        xy1 = rmvnorm(n/4, c( 3,  3))
        xy2 = rmvnorm(n/4, c(-3,  3))
        xy3 = rmvnorm(n/4, c(-3, -3))
        xy4 = rmvnorm(n/4, c( 3, -3))
        #MyPlot(rbind(xy1, xy2, xy3, xy4), xlim = c(-3-4, 3+4), ylim = c(-3-4, 3+4))
        return(rbind(xy1, xy2, xy3, xy4))
    }
)

class(gen_boigelot_four) <- "generator"

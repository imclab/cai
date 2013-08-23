# Christopher L. Simons, 2013

source("src/util.R")
source("src/core/rotate.R")

verboseMode <- TRUE

data <- gen_max_dependence$generate(param.n) # Data set comprising x = y.

# Comparing unrotated and rotated data.
#
#   Something is broken here.  This data set, x = y, yields a nice clean
#   scatter plot.  Rotating by pi/2 and pi/3 below give IDENTICAL results
#   according to the discretization matrix weight matrix output, which I
#   believe is accurate.  In both cases, we see the results we should get
#   from pi/2 (a perfect "90 degree" rotation of the line).  Using pi/4,
#   however, which should change the plot to a horizontal line (parallel
#   to the x axis), results in plots scattered willy nilly.  Perhaps an
#   overflow problem?
#
#   Once this issue is resolved, we can scale custom_stat and custom_sym
#   assessments properly and achieve clean 0 < x < 1 metric to compare
#   directly to the Pearson and Spearman coefficients.

print_weight_matrix(data)
print_weight_matrix(rotate(data, pi/4))

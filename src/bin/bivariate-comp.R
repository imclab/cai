# Christopher L. Simons, 2013

source("src/core/util/init.R")
p("Started program at [", date(), "].")
source("src/core/learning/support/train.R")

options(width = 160)

write.csv(bivariate.summary,
          file      = "bivariate-comp.csv",
          quote     = FALSE,
          row.names = FALSE,
          col.names = TRUE)

print.data.frame(bivariate.summary)

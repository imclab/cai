# Christopher L. Simons, 2013

source("src/core/util/util.R")
source("src/conf/properties.R")
source("src/core/util/init.R")
source("src/core/learning/support/train.R")

options(width = 160)

write.csv(bivariate.summary,
          file      = "bivariate-comp.csv",
          quote     = FALSE,
          row.names = FALSE,
          col.names = TRUE)

print.data.frame(bivariate.summary)

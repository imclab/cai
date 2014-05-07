# Copyright 2013, 2014 by Christopher L. Simons

stopifnot(require(modeest))
stopifnot(require(graph))
stopifnot(require(RBGL))
stopifnot(require(Rgraphviz))
stopifnot(require(pcalg))
stopifnot(require(energy))

source("src/core/util/util.R")
source("src/conf/properties.R")

p("Using Sturges' Rule for plot partitions",
  "; k = ",
  binCount(training.n),
  " for training data ...")

p("Using n = ", training.n, " data points for bivariate training ...")
p("Using n = ", testing.n, " data points for CI testing ...")

for (dirname in AUTOLOAD.DIRS)
    if (length(dirname) > 0)
        for (filename in list.files(path = dirname, pattern = ".+\\.R"))
            source(paste(dirname, "/", filename, sep = ""))

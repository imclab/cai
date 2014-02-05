# Christopher L. Simons, 2013

stopifnot(require(graph))
stopifnot(require(Rgraphviz))
stopifnot(require(pcalg))
stopifnot(require(energy))

source("src/core/util/util.R")
source("src/conf/properties.R")

if (break_method == "fixed") {
    p("Using fixed k = ", break.fixed.n, " plot partitions ...")
} else if (break_method == "sturges") {
    p("Using Sturges' Rule for plot partitions",
      "; k = ",
      bin_count(training.n),
      " for training data ...")
}

p("Using n = ", training.n, " data points for bivariate training ...")
p("Using n = ", testing.n, " data points for CI testing ...")

for (dirname in AUTOLOAD_DIRS)
    if (length(dirname) > 0)
        for (filename in list.files(path = dirname, pattern = ".+\\.R"))
            source(paste(dirname, "/", filename, sep = ""))

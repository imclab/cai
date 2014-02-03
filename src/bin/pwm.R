# Christopher L. Simons, 2013

source("src/core/util/init.R")
source("src/core/util/plot_disc.R")

p("Started program at [", date(), "].")

source("src/core/learning/support/train.R")
source("src/core/util/init_learners.R")

p("\nUsing n = ", training.n, " data points per generator ...\n")

assessments <- list()
generators <- list()
for (dirname in AUTOLOAD_DIRS)
    if (length(dirname) > 0)
        for (filename in list.files(path = dirname, pattern = ".+\\.R"))
            source(paste(dirname, "/", filename, sep = ""))

CAI__GEN_MODS_ORIG = CAI__GEN_MODS
CAI__GEN_MODS = c(1)
for (generator in generators) {
    data <- generator$generate(training.n)
    p("\n", generator$name, ":")
    print_weight_matrix(data)
}
CAI__GEN_MODS = CAI__GEN_MODS_ORIG

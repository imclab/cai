# Christopher L. Simons, 2013

source("src/util.R")
source("src/properties.R")
source("src/init.R")

p("\nUsing n = ", param.n, " data points per generator ...\n")

assessments <- list()
generators <- list()
for (dirname in AUTOLOAD_DIRS)
    if (length(dirname) > 0)
        for (filename in list.files(path = dirname, pattern = ".+\\.R"))
            source(paste(dirname, "/", filename, sep = ""))

# Only print default version of generators.
VAI__GEN_MOD = VAI__GEN_MOD_DEFAULT

for (generator in generators) {
    data <- generator$generate(param.n)
    p("\n", generator$name, ":")
    print_weight_matrix(data)
}

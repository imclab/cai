# Christopher L. Simons, 2013

source("src/util.R")
source("src/properties.R")

assessments <- list()
generators <- list()
for (dirname in AUTOLOAD_DIRS)
    if (length(dirname) > 0)
        for (filename in list.files(path = dirname, pattern = ".+\\.R"))
            source(paste(dirname, "/", filename, sep = ""))

#print_weight_matrix(data)
for (assessment in assessments)
    for (generator in generators)
        p(assessment$name, "\t", generator$name, "\t",
          assessment$assess(generator$generate(param.n)))

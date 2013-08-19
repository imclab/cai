# Christopher L. Simons, 2013

source("src/util.R")
source("src/properties.R")

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 0 && length(args) != 1)
        usage()

verboseMode <- FALSE
if (length(args) == 1) {
        verboseArg <- tolower(args[1])
    if (verboseArg != "true" && verboseArg != "false")
                usage()
        verboseMode <- (verboseArg == "true")
}

assessments <- list()
generators <- list()
for (dirname in AUTOLOAD_DIRS)
    if (length(dirname) > 0)
        for (filename in list.files(path = dirname, pattern = ".+\\.R"))
            source(paste(dirname, "/", filename, sep = ""))

# Scale assessment results to results of a maximally-dependent data set.
scale_factors <- list()
maxdep_data <- gen_max_dependence$generate(param.n)
for (assessment in assessments)
    scale_factors[[assessment$name]] <- assessment$assess(maxdep_data)

#print_weight_matrix(data)
for (generator in generators) {
    data <- generator$generate(param.n)
    annotation <- ""
    for (assessment in assessments) {
        result <- assessment$assess(data) / scale_factors[[assessment$name]]

        if (is.na(result))
            result <- "?"
        else if (result > 1)
            result <- "1 *"

        p(assessment$name, "\t", generator$name, "\t", result)
    }
}

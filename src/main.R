# Christopher L. Simons, 2013

source("src/util.R")
source("src/properties.R")

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1 && length(args) != 2)
    usage()

fileConfig <- args[1]

verboseMode <- FALSE
if (length(args) == 2) {
    verboseArg <- tolower(args[2])
    if (verboseArg != "true" && verboseArg != "false")
        usage()
    verboseMode <- (verboseArg == "true")
}

assessments <- c()
generators <- c()
for (dirname in AUTOLOAD_DIRS)
    if (length(dirname) > 0)
        for (filename in list.files(path = dirname, pattern = ".+\\.R"))
            source(paste(dirname, "/", filename, sep = ""))

tryCatch(source(fileConfig), error=function(e) corrupt(fileConfig, e))
if (!exists("param.n") || !exists("param.disc_bins")
        || !exists("param.generator") || !exists("param.assessment"))
    corrupt(fileConfig,
        "Expecting params {n, disc_bins, generator, assessment} to be defined.")

p("Successfully parsed configuration file.")

data <- param.generator$generate(param.n)
print_weight_matrix(data)

score <- param.assessment$assess(data)

p("Score: ", score)

# Christopher L. Simons, 2013

source("src/util.R")
source("src/assessments/assess_stat.R")
source("src/assessments/assess_sym.R")
source("src/generators/gen_basic_additive.R")
source("src/generators/gen_boigelot_sin.R")
source("src/generators/gen_boigelot_four.R")
source("src/generators/gen_boigelot_ex.R")
source("src/generators/gen_boigelot_ring.R")

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

tryCatch(source(fileConfig), error=function(e) corrupt(fileConfig, e))
if (!exists("param.n") || !exists("param.generator")
        || !exists("param.assessment") || !exists("param.alphas"))
    corrupt(fileConfig,
        "Expecting params {n, generator, assessment, alphas} to be defined.")

p("Successfully parsed configuration file.")

data <- param.generator$generate(param.n)
print_weight_matrix(data)

independent <- param.assessment$assess(data, param.alphas)

if (independent) {
    result <- "There is NOT a relationship between the variables."
} else {
    result <- "There IS a relationship between the variables."
}

p("Independence test result: ", result)

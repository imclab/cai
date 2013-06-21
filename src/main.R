# Christopher L. Simons, 2013

source("src/util.R")
source("src/assessments/assess_stat.R")
source("src/assessments/assess_sym.R")
source("src/generators/gen_basic_additive.R")

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1)
    eprint("usage: <script-name> <config-file>")

fileConfig <- args[1]
tryCatch(source(fileConfig), error=function(e) corrupt(fileConfig, e))
if (!exists("param.n") || !exists("param.generator")
        || !exists("param.assessment") || !exists("param.alphas"))
    corrupt(fileConfig,
        "Expecting params {n, generator, assessment, alphas} to be defined.")

p("Successfully parsed configuration file.")

data <- param.generator$generate(param.n)
print_weight_matrix(data)
p("Independence test result: ", param.assessment$assess(data, param.alphas))

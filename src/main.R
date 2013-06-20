# Christopher L. Simons, 2013

source("src/assessments/assess_stat.R")
source("src/assessments/assess_sym.R")
source("src/generators/gen_basic_additive.R")

p <- function(...) {
    cat(..., "\n", sep="", file="/dev/tty")
}

p_matrix <- function(x) {
    write(x, sep="\t", ncolumns=length(x[,1]), file="/dev/tty")
}

eprint <- function(...) {
    p(...)
    quit(status = 1, save = "no")
}

args <- commandArgs(trailingOnly = TRUE)

corrupt <- function(filename, e = "") {
    if (length(toString(e)) > 0)
        eprint("Fatal error reading configuration file \"",
               filename, "\":\n\t", toString(e))
    else
        eprint("Fatal error reading configuration file \"",
               filename, "\"; use hai-debug for detail.")
}

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

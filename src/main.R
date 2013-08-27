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

p("\nUsing n = ", param.n, " data points per generator ...\n")

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
df_assessment_name <- c()
df_generator_name <- c()
df_results <- c()

result_matrix_str <- "\t\t"
for (assessment in assessments)
    result_matrix_str <- paste(result_matrix_str, assessment$name, "\t", sep="")
result_matrix_str <- paste(result_matrix_str, "\n", sep="")

for (generator in generators) {
    data <- generator$generate(param.n)
    annotation <- ""
    result_matrix_str <- paste(result_matrix_str, generator$name, "\t", sep="")
    for (assessment in assessments) {
        result <- assessment$assess(data) / scale_factors[[assessment$name]]

        if (is.na(result))
            result <- "NA"

        df_assessment_name <- append(df_assessment_name, assessment$name)
        df_generator_name <- append(df_generator_name, generator$name)
        df_results <- append(df_results, result)
        p(assessment$name, "\t", generator$name, "\t", nformat(result))
        result_matrix_str <- paste(result_matrix_str, nformat(result), "\t\t", sep="")
    }
    result_matrix_str <- paste(result_matrix_str, "\n", sep="")
}

p("\n", result_matrix_str)
p("\n * scaling issue\n")

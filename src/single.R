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

for (dirname in AUTOLOAD_DIRS)
    if (length(dirname) > 0)
        for (filename in list.files(path = dirname, pattern = ".+\\.R"))
            source(paste(dirname, "/", filename, sep = ""))

#print_weight_matrix(data)
df_assessment_name <- c()
df_generator_name <- c()
df_results <- c()

result_matrix_str <- sprintf(fmt_s, "")
for (assessment in assessments)
    result_matrix_str <- paste(result_matrix_str,
                               sprintf(fmt_s, assessment$name))
result_matrix_str <- paste(result_matrix_str, "\n", sep="")

scores <- list()
for (generator in generators) {
    data <- generator$generate(param.n)
    annotation <- ""
    result_matrix_str <- paste(result_matrix_str,
                               sprintf(fmt_s, generator$name))

    p("Calculating assessment scores for generator '", generator$name, "' ...")
    for (assessment in assessments) {
        result <- assessment$assess(data)

        if (is.na(result))
            result <- "NA"

        if (is.null(scores[[assessment$name]]))
            scores[[assessment$name]] <- list()
        scores[[assessment$name]][[generator$name]] <- result

        #p(sprintf(fmt_s, assessment$name),
        #  sprintf(fmt_s, generator$name),
        #  sprintf(fmt_s, nformat(result)))
        result_matrix_str <- paste(result_matrix_str,
                                   sprintf(fmt_s, nformat(result)),
                                   sep="")
    }
    result_matrix_str <- paste(result_matrix_str, "\n", sep="")
}

p("\nOptimizing assessment score thresholds ...")

for (assessment in assessments) {
    best <- list()
    # TODO: Proper optimization rather than just checking arbitrary numbers.
    for (threshold in seq(0, 10, 0.5)) {
        ntotal <- 0
        nerror <- 0
        for (generator in generators) {
            ntotal <- ntotal + 1
            if (threshold < scores[[assessment$name]][[generator$name]]
                    && !generator$dependent)
                nerror <- nerror + 1
        }
        if (is.null(best$error_rate)
                || ((nerror / ntotal) < best$error_rate)) {
            best$threshold <- threshold
            best$error_rate <- (nerror / ntotal)
        }
    }
    p("Optimal (eh) threshold for assessment '", assessment$name, "' is [",
      best$threshold, "] with error rate of [", best$error_rate, "].")
}

p("\n", result_matrix_str)

# Christopher L. Simons, 2013

source("src/core/util/util.R")
source("src/conf/properties.R")
source("src/core/util/init.R")

p("\nUsing n = ", param.n, " data points per generator ...\n")

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

        result_matrix_str <- paste(result_matrix_str,
                                   sprintf(fmt_s, nformat(result)),
                                   sep="")
    }
    result_matrix_str <- paste(result_matrix_str, "\n", sep="")
}

p("\nOptimizing assessment score thresholds ...")

for (assessment in assessments) {
    best <- list()
    for (threshold in seq(0, 50, 0.1)) { # Improvement: Proper optimization?
        ntotal <- 0
        nerror <- 0
        for (generator in generators) {
            ntotal <- ntotal + 1
            if ((threshold < scores[[assessment$name]][[generator$name]]
                        && !generator$dependent) # false positive
                    || (scores[[assessment$name]][[generator$name]] < threshold
                        && generator$dependent)) # false negative
                nerror <- nerror + 1
        }
        if (is.null(best$error_rate)
                || ((nerror / ntotal) <= best$error_rate)) {
            best$threshold <- threshold
            best$error_rate <- (nerror / ntotal)
        }
    }
    p("Optimal (eh) threshold for assessment '", assessment$name, "' is [",
      best$threshold, "] with error rate of [", best$error_rate, "].")
}

p("\n", result_matrix_str)

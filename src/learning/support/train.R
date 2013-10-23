# Christopher L. Simons, 2013

p("Using n = ", training.n, " data points per generator ...")

result_matrix_str <- sprintf(fmt_s, "")
for (assessment in assessments)
    result_matrix_str <- paste(result_matrix_str,
                               sprintf(fmt_s, assessment$name))
result_matrix_str <- paste(result_matrix_str, "\n", sep="")

p("Training over synthetic data, 1/2 (scoring) ...")
scores <- list()
max_score <- NULL
for (generator in generators) {
    data <- generator$generate(training.n)
    data <- interval_scale(data)
    annotation <- ""

    result_matrix_str <- paste(result_matrix_str,
                               sprintf(fmt_s, generator$name))

    for (assessment in assessments) {
        result <- assessment$assess(data)

        if (is.na(result))
            result <- "NA"

        if (is.null(scores[[assessment$name]]))
            scores[[assessment$name]] <- list()

        scores[[assessment$name]][[generator$name]] <- result

        if (is.null(max_score) || max_score < result)
            max_score <- result

        result_matrix_str <- paste(result_matrix_str,
                                   sprintf(fmt_s, nformat(result)),
                                   sep="")
    }

    result_matrix_str <- paste(result_matrix_str, "\n", sep="")
}

p("Training over synthetic data, 2/2 (optimizing decision thresholds) ...")
thresholds <- list()
for (assessment in assessments) {
    best <- list()
    for (threshold in seq(0, max_score, 0.1)) { # Improvement: Proper optimization?
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
    thresholds[assessment$name] <- best$threshold
}

# Christopher L. Simons, 2013

bivariate.summary.header <- c("GENERATOR")
for (assessment in assessments)
    bivariate.summary.header <- append(bivariate.summary.header,
                                       assessment$name)

p("Training over synthetic data, 1/2 (scoring) ...")
scores <- list()
max_score <- NULL
bivariate.summary <- NULL
for (generator in generators) {
    data <- generator$generate(training.n)
    data <- interval_scale(data)
    annotation <- ""

    detail.row <- c(generator$name)
    for (assessment in assessments) {
        result <- assessment$assess(data)
        if (is.na(result))
            result <- "NA"

        if (is.null(scores[[assessment$name]]))
            scores[[assessment$name]] <- list()

        scores[[assessment$name]][[generator$name]] <- result

        if (is.numeric(result) && (is.null(max_score) || max_score < result))
            max_score <- result

        detail.row <- append(detail.row, nformat(result))
    }

    bivariate.summary <- rbind(bivariate.summary, detail.row)
}

bivariate.summary <- data.frame(bivariate.summary)
names(bivariate.summary) <- bivariate.summary.header

p("Training over synthetic data, 2/2 (optimizing decision thresholds) ...")
thresholds <- list()
for (assessment in assessments) {
    upperbound <- alpha(assessment, overrideLower = TRUE)
    lowerbound <- alpha(assessment, overrideLower = FALSE)
    # Use "middle" optimal value.
    thresholds[assessment$name] <- upperbound - lowerbound
}

alpha <- function(assessment, overrideLower) {
    best <- list()
    # Improvement: Proper optimization?
    for (threshold in seq(0, max_score, 0.01)) {
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
                || (overrideLower && ((nerror / ntotal) <= best$error_rate))
                || (!overrideLower && ((nerror / ntotal) < best$error_rate))) {
            best$threshold <- threshold
            best$error_rate <- (nerror / ntotal)
        }
    }
    return (best$threshold)
}

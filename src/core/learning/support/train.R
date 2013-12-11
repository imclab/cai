# Christopher L. Simons, 2013

alpha <- function(assessment, overrideLower) {
    best <- list()
    # improvement: proper optimization?
    for (threshold in seq(0, max_score, 0.01)) {
        n_total <- 0
        n_error <- 0
        for (generator in generators) {
            n_total <- n_total + 1
            if ((threshold < scores[[assessment$name]][[generator$name]]
                    && !generator$dependent) # false positive
                || (scores[[assessment$name]][[generator$name]] < threshold
                    && generator$dependent)) # false negative
                n_error <- n_error + 1
        }
        n_correct <- n_total - n_error

        if (is.null(best$error_rate)
                || (overrideLower && ((n_error / n_total) <= best$error_rate))
                || (!overrideLower && ((n_error / n_total) < best$error_rate))) {
            best$threshold <- threshold
            best$n_total <- n_total
            best$n_error <- n_error
            best$n_correct <- n_correct
            best$accuracy_str <- paste(n_correct, "/", n_total, sep="")
            best$error_rate <- (n_error / n_total)
        }
    }
    return (best)
}

p("Training over synthetic data, 1/2 (scoring) ...")
scores <- list()
max_score <- NULL
bivariate.summary <- NULL
for (generator in generators) {
    data <- generator$generate(training.n)
    data <- interval_scale(data)

    detail.row <- c(paste("$", generator$name, "$"))
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

p("Training over synthetic data, 2/2 (optimizing decision thresholds) ...")
thresholds <- list()
for (assessment in assessments) {
    p("\tTraining on assessment ", assessment$name, " [0..", max_score, "] ...")
    upperbound <- alpha(assessment, overrideLower = TRUE)
    lowerbound <- alpha(assessment, overrideLower = FALSE)
    # Use "middle" optimal value.
    score <- mean(c(lowerbound$threshold, upperbound$threshold))
    thresholds[assessment$name] <- score
    p("[", assessment$name, "]\t-> [ ",
      lowerbound$accuracy_str, " @ ", nformat(lowerbound$threshold),
      " < ", nformat(score), " < ",
      upperbound$accuracy_str, " @ ", nformat(upperbound$threshold), "].")
}

bivariate.summary.header <- c("GENERATOR")
for (assessment in assessments)
    bivariate.summary.header <- append(bivariate.summary.header,
                                       paste("$",
                                             assessment$name,
                                             "^{\\theta=",
                                             nformat(thresholds[assessment$name]),
                                             "}$",
                                             sep=""))

bivariate.summary <- data.frame(bivariate.summary)
names(bivariate.summary) <- bivariate.summary.header

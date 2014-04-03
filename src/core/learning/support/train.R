# Christopher L. Simons, 2013

alpha <- function(assessment, overrideLower)
{
    best <- list()
    # improvement: proper optimization?
    for (threshold in seq(0, max.score, 0.01))
    {
        n.total <- 0
        n.error <- 0
        for (generator in generators)
        {
            n.total <- n.total + 1
            if ((threshold < scores[[assessment$name]][[generator$name]]
                    && !generator$dependent) # false positive
                || (scores[[assessment$name]][[generator$name]] < threshold
                    && generator$dependent)) # false negative
                n.error <- n.error + 1
        }
        n.correct <- n.total - n.error

        if (length(best) == 0 # Best object is empty.
                || (overrideLower && ((n.error / n.total) <= best$error.rate))
                || (!overrideLower && ((n.error / n.total) < best$error.rate)))
        {
            best$threshold <- threshold
            best$n.total <- n.total
            best$n.error <- n.error
            best$n.correct <- n.correct
            best$accuracy.str <- paste(n.correct, "/", n.total, sep="")
            best$error.rate <- (n.error / n.total)
        }
    }
    return (best)
}

p("Training over synthetic data, 1/2 (scoring) ...")
scores <- list()
max.score <- NULL
bivariate.summary <- NULL
for (generator in generators)
{
    data <- generator$generate(training.n)
    data <- intervalScale(data)

    detail.row <- c(paste("$ ", generator$name,
                          (
                              if ((! grepl("^\\\\(u?)noise", generator$name))
                                    && (! grepl("^\\\\beta", generator$name)))
                                  " + \\noise $"
                              else
                                  " $"
                          ),
                          " & ",
                          "$",
                          (if (generator$dependent) "\\dep" else "\\ind"),
                          "$",
                          sep=""))
    for (assessment in assessments)
    {
        result <- assessment$assess(data)
        if (is.na(result))
            result <- "NA"

        if (is.null(scores[[assessment$name]]))
            scores[[assessment$name]] <- list()

        scores[[assessment$name]][[generator$name]] <- result

        if (is.numeric(result) && (is.null(max.score) || max.score < result))
            max.score <- result

        detail.row <- append(detail.row, nformat(result))
    }

    bivariate.summary <- rbind(bivariate.summary, detail.row)
}

p("Training over synthetic data, 2/2 (calculating alpha levels) ...")
for (assessment in assessments)
{
    p("\tTraining on assessment ", assessment$name, " [0..", max.score, "] ...")
    upperbound <- alpha(assessment, overrideLower = TRUE)
    lowerbound <- alpha(assessment, overrideLower = FALSE)

    assessment$alpha_min <- lowerbound$threshold
    assessment$alpha_max <- upperbound$threshold
    assessment$alpha_mid <- mean(c(lowerbound$threshold, upperbound$threshold))
    assessments[[assessment$name]] <- assessment

    p("[", assessment$name, "]\t-> [ ",
      lowerbound$accuracy.str, " @ ", nformat(assessment$alpha_min),
      " < ", nformat(assessment$alpha_mid), " < ",
      upperbound$accuracy.str, " @ ", nformat(assessment$alpha_max), "].")
}

# Formatting for LaTeX 'tabular' environment.
bivariate.summary.header <- c("$ f(x) $ & $ \\ind? $")
for (assessment in assessments)
    bivariate.summary.header <- append(bivariate.summary.header,
                                       paste("$",
                                             assessment$name,
                                             "^{\\alpha=",
                                             nformat(assessment$alpha_mid),
                                             "}$",
                                             sep=""))

bivariate.summary <- data.frame(bivariate.summary)
names(bivariate.summary) <- bivariate.summary.header

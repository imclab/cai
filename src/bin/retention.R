# Christopher L. Simons, 2013

source("src/core/util/util.R")
source("src/conf/properties.R")
source("src/core/util/init.R")

source("src/core/assessments/conditional/pcor.R")
source("src/core/assessments/conditional/comp.R")

p("Using n = ", param.n, " data points per generator ...")

p("Training over synthetic data, 1/2 (scoring) ...")
scores <- list()
for (generator in generators) {
    data <- generator$generate(param.n)
    annotation <- ""

    for (assessment in assessments) {
        result <- assessment$assess(data)

        if (is.na(result))
            result <- "NA"

        if (is.null(scores[[assessment$name]]))
            scores[[assessment$name]] <- list()
        scores[[assessment$name]][[generator$name]] <- result
    }
}

p("Training over synthetic data, 2/2 (optimizing decision thresholds) ...")
thresholds <- list()
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
    thresholds[assessment$name] <- best$threshold
}

data_ret <- read.table("data/retention-25.txt", header = TRUE)

p("Retention data available as 'data_ret'.")
p("CI tests ci_pcor and ci_comp available, taking (x, y, z, bit|a).")

p("Pearson pCor on data_ret[1:3] is [",
  ci_pcor(data_ret[,1], data_ret[,2], data_ret[,3]),
  "].")

p("Custom-SYM raw score on data_ret[1:3] is [",
  ci_comp(data_ret[,1], data_ret[,2], data_ret[,3],
          assessments$custom_sym$assess),
  "].")

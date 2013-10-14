# Christopher L. Simons, 2013

source("src/core/util/util.R")
source("src/conf/properties.R")
source("src/core/util/init.R")

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

x <- data_ret[,1]
y <- data_ret[,2]
z <- data_ret[,3]

p("Pearson  pCor on data_ret[1:3] is [", ci_pcor(x, y, z), "].")
p("Spearman pCor on data_ret[1:3] is [",
  ci_pcor(x, y, z, method_cor="spearman"), "].")
p("Kendall pCor on data_ret[1:3] is [",
  ci_pcor(x, y, z, method_cor="kendall"), "].")

p("Custom SC_INCR raw score on data_ret[1:3] is [",
  ci_comp(x, y, z, assessments$custom_sc_incr$assess), "].")

p("Custom SC_OPPO raw score on data_ret[1:3] is [",
  ci_comp(x, y, z, assessments$custom_sc_oppo$assess), "].")

p("Custom SC_RAND raw score on data_ret[1:3] is [",
  ci_comp(x, y, z, assessments$custom_sc_rand$assess), "].")

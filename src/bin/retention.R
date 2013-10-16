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

data_ret <- read.table("data/retention-10k.txt", header = TRUE)

p("Retention data available as 'data_ret'.")

ex.suffStat <- list(C = cor(data_ret), n = nrow(data_ret))
ex.fit      <- pc(suffStat  = ex.suffStat,
                  indepTest = gaussCItest,
                  p         = ncol(data_ret),
                  alpha     = 0.01)

#customCI <- list(method_cor = "pearson")
#pcor.fit <- pc(suffStat  = data_ret,
#               indepTest = ci_pcor,
#               p         = ncol(data_ret),
#               alpha     = 0.01)
#customCI <- list(bivariate_test = assessments$custom_sc_oppo$assess,
#                 threshold      = thresholds[assessments$custom_sc_oppo$name])
#comp.fit <- pc(suffStat  = data_ret,
#               indepTest = ci_comp,
#               p         = ncol(data_ret),
#               alpha     = 0.01)
#par(mfrow = c(1, 2)) # if multiple plots.

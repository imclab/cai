# Christopher L. Simons, 2013

for (dirname in c("src/core/assessments/bivariate/composite"))
    if (length(dirname) > 0)
        for (filename in list.files(path = dirname, pattern = ".+\\.R"))
            source(paste(dirname, "/", filename, sep = ""))

learner <- list(name  = "SC",
                learn = function(data.) {
                    result <- pc(suffStat
                                   = list(data = data.,
                                          bivariate_test =
                                            assessments$SC),
                                 indepTest = ci_comp,
                                 p         = ncol(data.),
                                 alpha     = thresholds$SC)
                    nodes(result@graph) <- names(data.)
                    return (result)
                })

class(learner) <- "learner"
learners[[length(learners) + 1]] <- learner

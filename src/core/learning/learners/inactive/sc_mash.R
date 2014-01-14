# Christopher L. Simons, 2013

learner <- list(name  = "SC_{mash}",
                learn = function(data.) {
                    result <- pc(suffStat
                                   = list(data = data.,
                                          bivariate_test =
                                            assessments[["SC_{mash}"]]),
                                 indepTest = ci_comp,
                                 p         = ncol(data.),
                                 alpha     = thresholds[["SC_{mash}"]])
                    nodes(result@graph) <- names(data.)
                    return (result)
                })

class(learner) <- "learner"
learners[[length(learners) + 1]] <- learner

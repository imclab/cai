# Christopher L. Simons, 2013

learner <- list(name  = "sc",
                learn = function(data.) {
                    result <- pc(suffStat
                                   = list(data = data.,
                                          bivariate_test =
                                            assessments$sc),
                                 indepTest = ci_comp,
                                 p         = ncol(data.),
                                 alpha     = thresholds$sc)
                    nodes(result@graph) <- names(data.)
                    return (result)
                })

class(learner) <- "learner"
learners[[length(learners) + 1]] <- learner

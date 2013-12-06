# Christopher L. Simons, 2013

learner <- list(name  = "sc_median",
                learn = function(data.) {
                    result <- pc(suffStat
                                   = list(data = data.,
                                          bivariate_test =
                                            assessments$sc_median),
                                 indepTest = ci_comp,
                                 p         = ncol(data.),
                                 alpha     = thresholds$sc_median)
                    nodes(result@graph) <- names(data.)
                    return (result)
                })

class(learner) <- "learner"
learners[[length(learners) + 1]] <- learner

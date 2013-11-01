# Christopher L. Simons, 2013

learner <- list(name  = "sc_sym",
                learn = function(data.) {
                    result <- pc(suffStat
                                   = list(data = data.,
                                          bivariate_test =
                                            assessments$sc_sym),
                                 indepTest = ci_comp,
                                 p         = ncol(data.),
                                 alpha     = thresholds$sc_sym)
                    nodes(result@graph) <- names(data.)
                    return (result)
                })

class(learner) <- "learner"
learners[[length(learners) + 1]] <- learner

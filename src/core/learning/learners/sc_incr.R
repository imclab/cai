# Christopher L. Simons, 2013

learner <- list(name  = "sc_incr",
                learn = function(data.) {
                    result <- pc(suffStat
                                   = list(data = data.,
                                          bivariate_test =
                                            assessments$custom_sc_incr$assess),
                                 indepTest = ci_comp,
                                 p         = ncol(data.),
                                 alpha     = thresholds$custom_sc_incr)
                    nodes(result@graph) <- names(data.)
                    return (result)
                })

class(learner) <- "learner"
learners[[length(learners) + 1]] <- learner

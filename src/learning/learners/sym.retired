# Christopher L. Simons, 2013

learner <- list(name  = "sym",
                learn = function(data.) {
                    result <- pc(suffStat
                                   = list(data = data.,
                                          bivariate_test =
                                            assessments$custom_sym$assess),
                                 indepTest = ci_comp,
                                 p         = ncol(data.),
                                 alpha     = thresholds$custom_sym)
                    nodes(result@graph) <- names(data.)
                    return (result)
                })

class(learner) <- "learner"
learners[[length(learners) + 1]] <- learner

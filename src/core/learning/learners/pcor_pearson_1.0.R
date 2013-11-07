# Christopher L. Simons, 2013

learner <- list(name  = "pcor::pearson::1.0",
                learn = function(data.) {
                    result <- pc(suffStat = list(data = data.,
                                                 method_cor = "pearson"),
                                 indepTest = ci_pcor,
                                 p         = ncol(data.),
                                 alpha     = 1.0)
                    nodes(result@graph) <- names(data.)
                    return (result)
                })

class(learner) <- "learner"
learners[[length(learners) + 1]] <- learner

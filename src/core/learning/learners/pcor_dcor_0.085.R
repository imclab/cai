# Christopher L. Simons, 2013

learner <- list(name  = "pcor::dcor::0.085",
                learn = function(data.) {
                    result <- pc(suffStat = list(data = data.,
                                                 method_cor = "dcor"),
                                 indepTest = ci_pcor,
                                 p         = ncol(data.),
                                 alpha     = 0.085)
                    nodes(result@graph) <- names(data.)
                    return (result)
                })

class(learner) <- "learner"
learners[[length(learners) + 1]] <- learner

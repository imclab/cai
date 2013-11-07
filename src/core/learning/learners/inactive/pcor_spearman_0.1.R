# Christopher L. Simons, 2013

learner <- list(name  = "pcor::spearman::0.1",
                learn = function(data.) {
                    result <- pc(suffStat = list(data = data.,
                                                 method_cor = "spearman"),
                                 indepTest = ci_pcor,
                                 p         = ncol(data.),
                                 alpha     = 0.1)
                    nodes(result@graph) <- names(data.)
                    return (result)
                })

class(learner) <- "learner"
learners[[length(learners) + 1]] <- learner

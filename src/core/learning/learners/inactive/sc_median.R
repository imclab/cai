# Christopher L. Simons, 2013

learner <- list(name="SC_{median}", learn=function(data.)
{
    result <- pc(suffStat  = list(data=data.,
                                  bivariate.test=assessments[["SC_{\\widetilde{x}}"]]),
                 indepTest = ciComp,
                 p         = ncol(data.),
                 alpha     = thresholds[["SC_{\\widetilde{x}}"]])
    nodes(result@graph) <- names(data.)
    return (result)
})
class(learner) <- "learner"
learners[[length(learners) + 1]] <- learner

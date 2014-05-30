# Copyright 2013, 2014 by Christopher L. Simons

learner <- list(name="CCI", learn=function(data.)
{
    result <- pc(suffStat  = list(data=data.),
                 indepTest = ci.test.partition,
                 p         = ncol(data.),
                 alpha     = 0.5) # CCI p-value will be 0 or 1.
                                  # Actual alpha can be set in CCI code.
    nodes(result@graph) <- names(data.)
    return (result)
})
class(learner) <- "learner"
learners[[length(learners) + 1]] <- learner

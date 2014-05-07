# Copyright 2013, 2014 by Christopher L. Simons

learner <- list(name="gaussCItest::0.1", learn=function(data.)
{
    result <- pc(suffStat  = list(C=cor(data.), n=nrow(data.)),
                 indepTest = gaussCItest,
                 p         = ncol(data.),
                 alpha     = 0.1)
    nodes(result@graph) <- names(data.)
    return (result)
})
class(learner) <- "learner"
learners[[length(learners) + 1]] <- learner

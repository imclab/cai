# Christopher L. Simons, 2013

learner <- list(name="benchmark", learn=function(data.)
{
    result <- pc(suffStat  = list(list(ci.test=ci.test.partition, suff.stat=list(data=data., assessment=assessment[["SC_{Mo}"]])),
                                  list(ci.test=ci.test.pcor,      suff.stat=list(data=data., method="pearson"))),
                 indepTest = ci.test.hook,
                 p         = ncol(data.),
                 alpha     = 1)
    nodes(result@graph) <- names(data.)
    return (result)
})
class(learner) <- "learner"
learners[[length(learners) + 1]] <- learner

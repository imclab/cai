# Christopher L. Simons, 2013

learner <- list(name="benchmark", learn=function(data.)
{
    result <- pc(suffStat  = list(list(ci.test=ci.test.partition,
                                       ci.test.name="mode",
                                       ci.suff.stat=list(data=data., assessment=assessments[["SC_{Mo}"]])),
                                  list(ci.test=ci.test.pcor,
                                       ci.test.name="pcor",
                                       ci.suff.stat=list(data=data., method.cor="pearson"))),
                 indepTest = ci.test.hook,
                 p         = ncol(data.),
                 alpha     = 1)
    nodes(result@graph) <- names(data.)
    return (result)
})
class(learner) <- "learner"
learners[[length(learners) + 1]] <- learner

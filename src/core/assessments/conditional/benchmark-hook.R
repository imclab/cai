# Christopher L. Simons, 2013

# We use this CI 'test' as a hook into the PC algorithm.  Here we always return
# dependence, causing a complete graph to be maintained by PC so that all
# combinations of variables will be tested for conditional independence.
# We test these relationships with all CI tests we wish to benchmark and store
# the results.
#
# The 'sufficient.stat' parameter is where we pass in required data for the
# benchmark.  The object should contain a list of 'CI packages', each in turn
# containing the following items:
#
#   ci.test         : conditional assessment.
#   ci.suff.stat    : sufficient statistic for above CI test.

ci.test.hook <- function(x, y, S, sufficient.stat)
{
    model <- NULL
    for (i in 1:length(models)) {
        if (models[[i]][["name"]] == "Retention-MN") {
            model <- models[[i]]
            break
        }
    }

    x.name <- x[1]
    y.name <- y[1]
    s.name <- ""

    for (i in 1:length(S)) {
        s.name <- paste(s.name, S[i], sep="")
        if (i < length(S))
            s.name <- paste(s.name, ",", sep="")
    }

    result.str <- ""
    for (i in 1:length(sufficient.stat)) {
        ci.test       <- sufficient.stat[[i]][["ci.test"]]
        ci.test.name. <- sufficient.stat[[i]][["ci.test.name"]]
        ci.suff.stat  <- sufficient.stat[[i]][["ci.suff.stat"]]

        ci.test.result <- ci.test(x, y, S, ci.suff.stat)

        result.str <- paste(result.str,
                            ci.test.name., "=", nformat(ci.test.result),
                            if (length(sufficient.stat) > i)
                                ";"
                            else
                                "", sep="")
    }

    newRow <- c(
        x.name,
        y.name,
        s.name,
        result.str
    )

    combo.results.table <<- rbind(combo.results.table, newRow)

    return (0)
}

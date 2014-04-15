# Christopher L. Simons, 2013

ci.test.gold <- function(x, y, S, sufficient.stat)
{
    data.  <- sufficient.stat$data
    graph. <- sufficient.stat$graph
    nodes. <- sufficient.stat$nodes

    if (is.null(data.))
        stop("ci.test.gold: sufficient.stat$data is NULL.")
    if (is.null(graph.))
        stop("ci.test.gold: sufficient.stat$graph is NULL.")

    labels.x <- nodes.[x]
    labels.y <- nodes.[y]
    labels.S <- nodes.[S]

    result <- if (ggm::dSep(as(graph., "matrix"),
                            labels.x, labels.y, labels.S))
                  0
              else
                  1

#    result <- if (dsep(nodes.[x], nodes.[y], nodes.[S], graph.))
#                  0
#              else
#                  1

#    result <- dsepTest(x, y, S,
#                       list(g=graph.,
#                            jp=johnson.all.pairs.sp(graph.)))

    verbose("Called ci.test.pcor:", x, ",", y, ",[|", ncol(S.),
      "|]\t-> ", nformat(result), ".")

    return (result)
}

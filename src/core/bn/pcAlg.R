# Christopher L. Simons, 2013

library(graph)

pcAlg <- function(pc_dataset, ci_test) {
    g <- graphNEL(nodes=names(data_ret), edgemode="directed")
    pairs <- combn(names(data_ret), 2)
    for (i in 1:length(pairs[1,])) {
        pair <- pairs[,i]
        g <- addEdge(pair[1], pair[2], g)
        g <- addEdge(pair[2], pair[1], g)
    }

    #triplets <- combn(names(data_ret), 3)
    #for (i in 1:length(triplets[1,])) {
    #    triple <- triplets[,i]
    #    p("Would have tested triplet [", triple[1], ", ", triple[2], ", ", triple[3], "].")
    #}

    return (g)
}

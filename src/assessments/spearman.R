# Christopher L. Simons, 2013

assessment <- list(name = "spearman", assess = function(data) {
    return (cor(x      = data[,1],
                y      = data[,2],
                use    = "complete.obs",
                method = "spearman"))
})

class(assessment) <- "assessment"
assessments[[length(assessments) + 1]] <- assessment

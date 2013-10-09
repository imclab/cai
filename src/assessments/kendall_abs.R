# Christopher L. Simons, 2013

assessment <- list(name = "kendall_abs", assess = function(data) {
    return (abs(cor(x      = data[,1],
                    y      = data[,2],
                    use    = "complete.obs",
                    method = "kendall")))
})

class(assessment) <- "assessment"
assessments[[length(assessments) + 1]] <- assessment

# Christopher L. Simons, 2013

assessment <- list(name = "pearson_abs", assess = function(data) {
    return (abs(cor(x      = data[,1],
                    y      = data[,2],
                    use    = "complete.obs",
                    method = "pearson")))
})

class(assessment) <- "assessment"
assessments[[assessment$name]] <- assessment

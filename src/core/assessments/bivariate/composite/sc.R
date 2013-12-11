# Christopher L. Simons, 2013

assessment <- list(name = "sc", assess = function(data) {
    dep <- FALSE
    for (assessment in assessments) {
        if (assessment$assess(data) > thresholds[assessment$name]) {
            dep <- TRUE
            break
        }
    }
    return (if (dep) 1 else 0)
})

class(assessment) <- "assessment"
assessments[[assessment$name]] <- assessment
thresholds[[assessment$name]] <- 0.5

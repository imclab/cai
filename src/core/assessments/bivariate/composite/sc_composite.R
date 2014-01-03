# Christopher L. Simons, 2013

assessment <- list(name = "SC", assess = function(data) {
    dep <- FALSE
    for (i in assessments) {
        if (length(grep("SC_", i$name)) > 0) {
            if (i$assess(data) > thresholds[[i$name]]) {
                dep <- TRUE
                break
            }
        }
    }
    return (if (dep) 1 else 0)
})

class(assessment) <- "assessment"
assessments[[assessment$name]] <- assessment
thresholds[[assessment$name]] <- 0.5

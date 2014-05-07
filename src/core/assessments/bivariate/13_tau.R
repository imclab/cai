# Copyright 2013, 2014 by Christopher L. Simons

assessment <- list(name="\\tau", assess=function(data)
{
    return (abs(cor(x      = data[,1],
                    y      = data[,2],
                    use    = "complete.obs",
                    method = "kendall")))
})
class(assessment) <- "assessment"
assessments[[assessment$name]] <- assessment

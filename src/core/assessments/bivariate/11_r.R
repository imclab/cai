# Copyright 2013, 2014 by Christopher L. Simons

assessment <- list(name="r", assess=function(data)
{
    return (abs(cor(x      = data[,1],
                    y      = data[,2],
                    use    = "complete.obs",
                    method = "pearson")))
})
class(assessment) <- "assessment"
assessments[[assessment$name]] <- assessment

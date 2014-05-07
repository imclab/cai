# Copyright 2013, 2014 by Christopher L. Simons

assessment <- list(name="dCor", assess=function(data)
{
    return (dcor(x = data[,1],
                 y = data[,2]))
})
class(assessment) <- "assessment"
assessments[[assessment$name]] <- assessment

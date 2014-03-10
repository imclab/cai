# Christopher L. Simons, 2013

assessment <- list(name="dCor", assess=function(data)
{
    return (dcor(x = data[,1],
                 y = data[,2]))
})
class(assessment) <- "assessment"
assessments[[assessment$name]] <- assessment

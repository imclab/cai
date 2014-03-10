param.verbose = TRUE

training.n    = 2000
testing.n     = 20000
fmt.s         = "%19s"
break.method  = "sturges"
#break.method  = "fixed"
#break.fixed.n = 20

AUTOLOAD.DIRS = c(
    "src/core/generators",
    "src/core/assessments/bivariate",
    "src/core/assessments/conditional",
    "src/core/learning/models",
"")

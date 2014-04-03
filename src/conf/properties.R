param.verbose = TRUE

training.n    = 2000
testing.n     = 20000
fmt.s         = "%19s"

AUTOLOAD.DIRS = c(
    "src/core/generators",
    "src/core/assessments/bivariate",
    "src/core/learning/models",
    "src/core/learning/support",

    # Train before loading conditional tests
    # so that alpha-levels are set in the
    # bivariate assessment components.
    #
    "src/core/assessments/conditional",
"")

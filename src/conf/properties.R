param.verbose = TRUE

training.n    = 2000
testing.n     = 20000
fmt_s         = "%19s"
break_method  = "sturges"
#break_method  = "fixed"
#break.fixed.n = 20

# Generator "sigma" modifiers.
CAI__GEN_MOD_DEFAULT = 1
CAI__GEN_MODS        = c(0.01, 0.1, 1, 10, 100)
#CAI__GEN_MODS        = c(1)

AUTOLOAD_DIRS = c(
    "src/core/generators",
    "src/core/assessments/bivariate",
    "src/core/assessments/conditional",
    "src/core/learning/learners",
    "src/core/learning/models",
"")

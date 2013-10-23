training.n    = 2000
testing.n     = 2000
fmt_s         = "%19s"
break.fixed.n = 10
break_method  = "fixed" # alternative: "sturges"

# Generator "sigma" modifiers.
CAI__GEN_MOD_DEFAULT = 1
CAI__GEN_MODS        = c(1, 10, 0.1, 0.01)

AUTOLOAD_DIRS = c(
    "src/core/generators",
    "src/core/assessments/bivariate",
    "src/core/assessments/conditional",
    "src/learning/models",
"")

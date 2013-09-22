param.n         = 1000

#param.disc_bins = 10
param.disc_bins = bin_count_sturge(param.n)

# Generator "sigma" modifiers.
VAI__GEN_MOD_DEFAULT = 1
VAI__GEN_MODS = c(1, 10, 0.1, 0.01)

AUTOLOAD_DIRS = c(
    "src/generators",
    "src/assessments",
"")

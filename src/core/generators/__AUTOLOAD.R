generators <- list()

#for (dirname in c("src/core/generators/static"))
#    if (length(dirname) > 0)
#        for (filename in list.files(path = dirname, pattern = ".+\\.R"))
#            source(paste(dirname, "/", filename, sep = ""))

for (dirname in c("src/core/generators/dynamic")) {
    if (length(dirname) > 0) {
        for (filename in list.files(path = dirname, pattern = ".+\\.R")) {
            if (filename != "__AUTOLOAD.R") {
                for (i in 1:length(CAI__GEN_MODS)) {
                    CAI__GEN_MOD = CAI__GEN_MODS[i]
                    source(paste(dirname, "/", filename, sep = ""))
                }
            }
        }
    }
}

# Offset dependent generators with equal number of independent generators:
for (i in 1:length(generators)) {
    generator <- list(name = paste("\\noise_{", i, "}::",
                                   CAI__GEN_MOD, sep=""),
                      dependent = FALSE,
                      modifiable = TRUE,
                      generate = function(n) {
            x <- rnorm(n, 0, 1 * CAI__GEN_MOD)
            y <- rnorm(n, 0, 1 * CAI__GEN_MOD)
            return (cbind(x, y))
        }
    )
    class(generator) <- "generator"
    generators[[length(generators) + 1]] <- generator
}

# Remove modifier annotation if not using multiple modifiers:
if (length(CAI__GEN_MODS) == 1)
    for (generator in generators)
        generator$name <- gsub("::([^ ]+)", "", generator$name)

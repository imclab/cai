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

if (length(CAI__GEN_MODS) == 1)
    for (generator in generators)
        generator$name <- gsub("::([^ ]+)", "", generator$name)

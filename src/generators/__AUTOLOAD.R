generators <- list()

for (dirname in c("src/generators/static"))
    if (length(dirname) > 0)
        for (filename in list.files(path = dirname, pattern = ".+\\.R"))
            source(paste(dirname, "/", filename, sep = ""))

for (dirname in c("src/generators/dynamic")) {
    if (length(dirname) > 0) {
        for (filename in list.files(path = dirname, pattern = ".+\\.R")) {
            for (i in 1:length(VAI__GEN_MODS)) {
                VAI__GEN_MOD = VAI__GEN_MODS[i]
                source(paste(dirname, "/", filename, sep = ""))
            }
            VAI__GEN_MOD = VAI__GEN_MOD_DEFAULT
        }
    }
}

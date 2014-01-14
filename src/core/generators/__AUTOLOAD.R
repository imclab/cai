generators <- list()

%for (dirname in c("src/core/generators/static"))
%    if (length(dirname) > 0)
%        for (filename in list.files(path = dirname, pattern = ".+\\.R"))
%            source(paste(dirname, "/", filename, sep = ""))

%for (dirname in c("src/core/generators/dynamic")) {
for (dirname in c("src/core/generators")) {
    if (length(dirname) > 0) {
        for (filename in list.files(path = dirname, pattern = ".+\\.R")) {
            for (i in 1:length(CAI__GEN_MODS)) {
                CAI__GEN_MOD = CAI__GEN_MODS[i]
                source(paste(dirname, "/", filename, sep = ""))
            }
            CAI__GEN_MOD = CAI__GEN_MOD_DEFAULT
        }
    }
}

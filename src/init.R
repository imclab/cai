# Christopher L. Simons, 2013

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 0 && length(args) != 1)
        usage()

verboseMode <- FALSE
if (length(args) == 1) {
        verboseArg <- tolower(args[1])
    if (verboseArg != "true" && verboseArg != "false")
                usage()
        verboseMode <- (verboseArg == "true")
}

for (dirname in AUTOLOAD_DIRS)
    if (length(dirname) > 0)
        for (filename in list.files(path = dirname, pattern = ".+\\.R"))
            source(paste(dirname, "/", filename, sep = ""))

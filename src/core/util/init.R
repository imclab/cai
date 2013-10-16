# Christopher L. Simons, 2013

stopifnot(require(graph))
stopifnot(require(Rgraphviz))
stopifnot(require(pcalg))

for (dirname in AUTOLOAD_DIRS)
    if (length(dirname) > 0)
        for (filename in list.files(path = dirname, pattern = ".+\\.R"))
            source(paste(dirname, "/", filename, sep = ""))

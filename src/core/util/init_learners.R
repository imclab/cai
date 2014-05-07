# Copyright 2013, 2014 by Christopher L. Simons

for (dirname in c("src/core/learning/learners"))
    if (length(dirname) > 0)
        for (filename in list.files(path = dirname, pattern = ".+\\.R"))
            source(paste(dirname, "/", filename, sep = ""))

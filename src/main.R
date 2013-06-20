# Christopher L. Simons, 2013

p <- function(...) {
    cat(..., "\n", sep="", file="/dev/tty")
}

eprint <- function(...) {
    p(...)
    quit(status = 1, save = "no")
}

args <- commandArgs(trailingOnly = TRUE)

configCorrupt <- function(filename, e) {
    if (length(toString(e)) > 0)
        eprint("Fatal error reading configuration file \"",
               filename, "\":\n\t", toString(e))
    else
        eprint("Fatal error reading configuration file \"",
               filename, "\"; use hai-debug for detail.")
}

if (length(args) != 1)
    eprint("usage: <script-name> <config-file>")

fileConfig <- args[1]
tryCatch(source(fileConfig), error=function(e) configCorrupt(fileConfig, e))
if (!exists("k") || !exists("n")
        || !exists("generator") || !exists("assessment"))
    configCorrupt(fileConfig,
                  "\n\tExpecting {k, n, generator, assessment} to be defined.")

p("Successfully parsed configuration file.")

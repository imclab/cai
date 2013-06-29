# Christopher L. Simons, 2013

p <- function(...) {
    cat(..., "\n", sep="", file="/dev/tty")
}

verbose <- function(...) {
    if (verboseMode)
        p(...)
}

p_matrix <- function(x) {
    write(x, sep="\t", ncolumns=length(x[,1]), file="/dev/tty")
}

eprint <- function(...) {
    p(...)
    quit(status = 1, save = "no")
}

usage <- function() {
    eprint("usage: <script-name> <config-file> [verbose-mode-boolean]")
}

corrupt <- function(filename, e = "") {
    if (length(toString(e)) > 0)
        eprint("Fatal error reading configuration file \"",
               filename, "\":\n\t", toString(e))
    else
        eprint("Fatal error reading configuration file \"",
               filename, "\"; use hai-debug for detail.")
}

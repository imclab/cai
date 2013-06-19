# Christopher L. Simons, 2013

p <- function(...) {
    cat(..., "\n", file="/dev/tty")
}

usage <- function() {
    p("usage: <script-name> <config-file>")
    quit(status = 1, save = "no")
}

args <- commandArgs(trailingOnly = TRUE)

p("Number of arguments passed:", length(args))

if (length(args) != 1)
    usage()

p("You passed in \"", args[1], "\".  Good job.", sep="")

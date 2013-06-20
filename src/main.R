# Christopher L. Simons, 2013

p <- function(...) {
    cat(..., "\n", sep="", file="/dev/tty")
}

usage <- function(args) {
    p("Got ", length(args), " arguments, expecting 1.")
    p("usage: <script-name> <config-file>")
    quit(status = 1, save = "no")
}

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1)
    usage(args)

p("You passed in \"", args[1], "\".  Good job.")

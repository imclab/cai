# Copyright 2013, 2014 by Christopher L. Simons

source("src/core/util/init.R")
p("Started main logic at [", date(), "].")

options(width=160)

# Formatting for LaTeX 'tabular' environment.
write.table(bivariate.summary,
            file      = "bivariate-comp.texf",
            quote     = FALSE,
            row.names = FALSE,
            col.names = TRUE,
            sep       = " & ",
            eol       = " \\\\\n")

print.data.frame(bivariate.summary)

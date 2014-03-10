# Christopher L. Simons, 2013

source("src/core/util/init.R")
p("Started program at [", date(), "].")
source("src/core/learning/support/train.R")

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

# Christopher L. Simons, 2013

source("src/core/util/util.R")
source("src/conf/properties.R")
source("src/core/util/init.R")
source("src/learning/train.R")

data. <- read.csv("data/iris.data", header = TRUE)
data. <- data.frame(interval_scale(as.matrix(data.)))

# TODO: Create "gold standard" graph for evaluation of learned structures.
gold <- graphNEL(nodes=names(data.), edgemode="directed")
gold <- addEdge("class", "sepal_length", gold)
gold <- addEdge("class", "sepal_width", gold)
gold <- addEdge("class", "petal_length", gold)
gold <- addEdge("class", "petal_width", gold)

p("Retention data available as 'data.'.")

p("Learning structure using pcalg::gaussCItest ...")
gauss.suffStat <- list(C = cor(data.), n = nrow(data.))
gauss.fit      <- pc(suffStat  = gauss.suffStat,
                     indepTest = gaussCItest,
                     p         = ncol(data.),
                     alpha     = 0.1)
nodes(gauss.fit@graph) <- names(data.)

p("Learning structure using pcor test ...")
pcor.fit <- pc(suffStat  = list(data = data.,
                                method_cor = "pearson"),
               indepTest = ci_pcor,
               p         = ncol(data.),
               alpha     = 0.1)
nodes(pcor.fit@graph) <- names(data.)

p("Learning structure using computational test (may take a while) ...")
comp_rand.fit <- pc(suffStat  = list(data = data.,
                                     bivariate_test = assessments$custom_sc_rand$assess),
                    indepTest = ci_comp,
                    p         = ncol(data.),
                    alpha     = thresholds$custom_sc_rand)
nodes(comp_rand.fit@graph) <- names(data.)

comp_incr.fit <- pc(suffStat  = list(data = data.,
                                     bivariate_test = assessments$custom_sc_incr$assess),
                    indepTest = ci_comp,
                    p         = ncol(data.),
                    alpha     = thresholds$custom_sc_incr)
nodes(comp_incr.fit@graph) <- names(data.)

comp_oppo.fit <- pc(suffStat  = list(data = data.,
                                     bivariate_test = assessments$custom_sc_oppo$assess),
                    indepTest = ci_comp,
                    p         = ncol(data.),
                    alpha     = thresholds$custom_sc_oppo)
nodes(comp_oppo.fit@graph) <- names(data.)

sym.fit <- pc(suffStat  = list(data = data.,
                               bivariate_test = assessments$custom_sym$assess),
              indepTest = ci_comp,
              p         = ncol(data.),
              alpha     = thresholds$custom_sym)
nodes(sym.fit@graph) <- names(data.)

p("Computing learned-model quality ...")

p("         gauss: ", shd(gold, gauss.fit))
p("          pcor: ", shd(gold, pcor.fit))
p("     comp_rand: ", shd(gold, comp_rand.fit))
p("     comp_incr: ", shd(gold, comp_incr.fit))
p("     comp_oppo: ", shd(gold, comp_oppo.fit))
p("           sym: ", shd(gold, sym.fit))

p("Plotting learned structures ...")
par(mfrow = c(2, 4)) # 1, 3
plot(gold)
plot(gauss.fit)
plot(pcor.fit)
plot(comp_rand.fit)
plot(comp_incr.fit)
plot(comp_oppo.fit)
plot(sym.fit)

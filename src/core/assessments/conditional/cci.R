# Copyright 2013, 2014 by Christopher L. Simons

# Ported from "Cci.java" in TETRAD 5.0.0-7 source distribution.
#
# All comments in source code below are from TETRAD source,
# unless explicitly annotated as a "porting note".
#
ci.test.cci <- function(x, y, S, sufficient.stat)
{
    data. <- sufficient.stat$data

    if (is.null(data.))
        stop("ci.test.cci: sufficient.stat$data is NULL.")

    # S. <- as.matrix(data.[,S])

    # Here, parameters {x., y., S.} are (single or vectors of) indices of "data.".
    is.independent <- function(x., y., S.)
    {
        r.xy <- residuals.nonparametric(x., y.)
        r.yz <- residuals.nonparametric(y., S.)
        return (independent.cci(r.xy, r.yz))
    }

    # Returns TRUE just in case the X and Y vectors are independent,
    # once undefined values have been removed.
    #
    independent.cci <- function(x.., y..)
    {
        #
        # BEGIN: LOGIC TO REMOVE MISSING VALUES.
        #
        both <- 0
        for (i in 1:length(x..))
            if (!is.na(x..[i]) && !is.null(x..[i])
                    && !is.na(y..[i]) && !is.null(y..[i]))
                both <- both + 1

        r.xy <- c()
        r.yz <- c()
        index <- (-1)

        if (both != length(x..)) {
            index <- 0
            for (i in 1:length(x..)) {
                if (!is.na(x..[i]) && !is.null(x..[i])
                        && !is.na(y..[i]) && !is.null(y..[i])) {
                    index <- index + 1
                    r.xy[index] <- x..[i]
                    r.yz[index] <- y..[i]
                }
            }
        }

        x... <- r.xy
        y... <- r.yz
        #
        # END: LOGIC TO REMOVE MISSING VALUES.
        #

        if (length(x...) < 10) {
            min.p <- NA
            return (FALSE) # For PC, should not remove edge for this reason.
        }

        xb <- c()
        yb <- c()
        for (m in 1:length(getNumFns())) {
            for (n in 1:length(getNumFns())) {
                for (i in 1:length(x...)) {
                    xb[i] <- cciFn(m, x...[i])
                    yb[i] <- cciFn(n, y...[i])
                }

                sigma.xy <- covariance.(xb, yb)
                sigma.xx <- covariance.(xb, xb)
                sigma.yy <- covariance.(yb, yb)

                r <- sigma.xy / sqrt(sigma.xx * sigma.yy)

                # Nonparametric Fisher-Z test:
                #
                z <- 0.5 * (log(1 + r) - log(1 - r)) # TODO: Right log()?
                w <- sqrt(length(x...) * z)

                # Testing and hypothesis that xb and yb are uncorrelated
                # and assuming that fourth moments of xb and yb are finite
                # and that the sample is large.
                #
xb1 <- xb
                standardize(xb)
p("xb same after standardize() call? -> [", xb1 == xb, "]")
                standardize(yb)

                t2 <- moment22(xb, yb)
                t <- sqrt(t2)
                p. <- 2 * (1 - normal.cdf(0, t, abs(w)))
                if (!is.na(p.) && !is.null(p.))
                    p.val <- append(p, p.)
            }
        }

        p.val  <- sort(p)
        cutoff <- fdr(alpha, p, TRUE)
        min.   <- if (length(p) == 0) NA else p[1]
        min.p  <- min.

        if (is.na(min.) || is.null(min.))
            return (TRUE) # No basis on which to remove an edge for PC.

        return (min. > cutoff)
    }

    # Here, parameters {x.., z..} are (single or vectors of) indices of "data.".
    residuals.nonparametric <- function(x., z.)
    {
        x.. <- as.matrix(data.[,x.])
        z.. <- as.matrix(data.[,z.])

        n <- nrow(x..)
        residuals. <- c()

        if (length(z..) == 0) {
            for (i in 1:length(n)) {
                residuals. <- append(residuals., x..[i])
            }
        } else {
            h. <- 0
            for (i in 1:length(z.)) {
                if (h.widths[[i]] > h.)
                    h. <- h.widths[[i]]
            }
            h. <- h. * sqrt(length(z.))

            sums <- list()
            weights <- list()

            for (i in 1:n) {
                xi <- x.[i]

                j <- i + 1
                while (j <= n) {
                    d. <- distance.euclidean(data., z., i, j)
                    k. <- kernel.(d. / h.)
                    xj <- x.[j]

                    sums[[i]] <- sums[[i]] + (k. * xj)
                    weights[[i]] <- weights[[i]] + k.

                    sums[[j]] <- sums[[j]] + (k. * xi)
                    weights[[j]] <- weights[[j]] + k.

                    j <- j + 1
                }
            }

            for (i in 1:n) {
                xi <- x.[i]
                d. <- distance.euclidean(data., z., i, i)
                k. <- kernel.(d. / h.)
                sums[[i]] <- sums[[i]] + (k. * xi)
                weights[[i]] <- weights[[i]] + k.
            }

            for (i in 1:n)
                residuals. <- append(residuals.,
                                     x.[i] - (sums[[i]] / weights[[i]]))
        }

        return (residuals.)
    }

    # ----------------------------------------
    # TETRAD class private methods follow.
    # ----------------------------------------

    moment22 <- function(x.., y..)
    {
        sum <- 0;

        for (i in 1:length(x..))
            sum <- sum + (x..[i] * x..[i] * y..[i] * y..[i])

        return (sum / length(x..))
    }

    # Polynomial basis. The 1 is left out according to Daudin.
    #
    cciFn <- function(index, xi)
    {
        g <- 1;
        for (i in 1:index)
            g <- g * xi

        return (g)
    }

    getNumFns <- function() { return (10) }

    covariance. <- function(x.., y..)
    {
        sum.xy <- 0
        sum.x  <- 0
        sum.y  <- 0
        n <- length(x..)

        for (i in 1:n)
        {
            sum.xy <- sum.xy + (x..[i] * y..[i])
            sum.x  <- sum.x + x..[i]
            sum.y  <- sum.y + y..[i]
        }

        return ((sum.xy / n) - ((sum.x / n) * (sum.y / n)))
    }

    # Optimal bandwidth q suggested by
    # Bowman and Azzalini (1997) q.31, using MAD.
    #
    h <- function(x..)
    {
        # TODO: Rather than porting string arg, using vector argument instead.
        #       Make sure calling functions use this type!
        g <- c()
        median.x <- median(x..)

        for (i in 1:length(x..))
            g <- append(g, abs(x..[i] - median.x))

        mad. <- median(g)

        return ((1.4826 * mad.) * (((4/3) / length(x..)) ** 0.2))
    }

    # Uniform kernel.
    #
    kernel. <- function(z)
    {
        return (if (abs(z) > 1) 0 else 0.5)
    }

    distance.euclidean <- function(data.., y.cols, i, j)
    {
        sum <- 0

        for (k in y.cols)
        {
            d <- data..[i, k] - data..[j, k]
            sum <- sum + (d * d)
        }

        return (sqrt(sum))
    }

    standardize <- function(data..) # TODO: Check that data is modified in caller.
    {
        mean. <- mean(data..)
        sd. <- sd(data..)

        for (i in 1:length(data..))
        {
            data..[i] <- data..[i] - mean.
            data..[i] <- data..[i] / sd.
        }
    }

    # False discovery rate, assuming non-negative correlations.
    #
    fdr <- function(alpha, p.values, p.sorted) {
        if (!p.sorted)
            p.values = sort(p.values)

        m <- length(p.values)

        index <- (-1)

        for (k in 1:m)
            if (p.values[k] <= ((k + 1) / (m + 1)) * alpha)
                index <- k

        return (if (index == (-1))
                    0
                else
                    p.values[index])
    }

    normal.cdf <- function(mean., sd., value) {
        #
        # Porting note:
        #
        # Java version, based on Apache Commons Math library:
        # (new NormalDistribution()).cumulativeProbability((value - mean) / sd)
        #
        # TODO: This is equivalent to the above, right?
        #
        return (dnorm((value - mean.) / sd.))
    }

    calculate.fdr.q <- function() {
        #
        # If a legitimate p.val value is desired for this test,
        # should estimate the FDR q value.
        #
        p.val <- sort(p)     # TODO: global reference!
        min.  <- min(p)
        high  <- 1
        low   <- 0
        q     <- alpha       # TODO: global reference!

        while ((high - low) > (1e-5)) {
            midpoint <- (high + low) / 2
            q        <- midpoint
            sorted   <- TRUE
            cutoff   <- fdr(q, p, sorted)

            if (cutoff < min.) {
                low <- midpoint
            } else if (cutoff > min.) {
                high <- midpoint
            } else {
                low <- midpoint
                high <- midpoint
            }
        }

        return (q)
    }

    # ----------------------------------------
    # Top-level logic follows.
    # ----------------------------------------
    alpha <- 0.25

    p.val <- c()
    min.p <- NULL
    h.widths <- list()

    for (i in 1:ncol(data.))
        h.widths[[i]] <- h(data.[,i])

    result <- if (is.independent(x, y, S)) 1 else 0

    verbose("Called ci.test.cci:", x, ",", y, ",[|", length(S),
            "|]\t-> ", result, ".")

    return (result)
}

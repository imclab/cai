# Christopher L. Simons, 2013

model <- list()

g <- graphNEL(edgemode = "directed",
              nodes    = c("temp_t0",
                           "temp_t1",
                           "sensor",
                           "temp_outside"))

g <- addEdge("temp_t0", "sensor", g)
g <- addEdge("temp_t0", "temp_t1", g)
g <- addEdge("temp_outside", "temp_t1", g)

temp_t0      <- rnorm(testing.n, 70, 5)  # Temperature inside at t=0.
temp_outside <- rnorm(testing.n, 60, 25) # Temperature outside at t=0.
sensor       <- temp_t0 + rnorm(1, 0, 5) # Thermostat reading at t=0.
temp_t1      <- temp_t0                  # Temperature inside at t-1.
                + ((temp_outside - temp_t0) * 0.2)
                + rnorm(1, 0, 5)

d <- data.frame(cbind(temp_t0, temp_outside, sensor, temp_t1))

model = list(name  = "temperature.continuous",
             graph = g,
             data  = interval_scale(d))

class(model) <- "model"
models[[length(models) + 1]] <- model

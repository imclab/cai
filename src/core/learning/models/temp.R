# Copyright 2013, 2014 by Christopher L. Simons

model <- list()

g <- graphNEL(edgemode = "directed",
              nodes    = c("temp_t0",
                           "temp_t1",
                           "temp_t2",
                           "temp_t3",
                           "sensor_t0",
                           "sensor_t1",
                           "sensor_t2",
                           "temp_outside_t0",
                           "temp_outside_t1",
                           "temp_outside_t2"))

g <- addEdge("temp_t0", "sensor_t0", g)
g <- addEdge("temp_t0", "temp_t1", g)
g <- addEdge("temp_outside_t0", "temp_t1", g)
g <- addEdge("temp_outside_t0", "temp_outside_t1", g)

g <- addEdge("temp_t1", "sensor_t1", g)
g <- addEdge("temp_t1", "temp_t2", g)
g <- addEdge("temp_outside_t1", "temp_t2", g)
g <- addEdge("temp_outside_t1", "temp_outside_t2", g)

g <- addEdge("temp_t2", "sensor_t2", g)
g <- addEdge("temp_t2", "temp_t3", g)
g <- addEdge("temp_outside_t2", "temp_t3", g)

temp_t0         <- rnorm(testing.n, 70, 5)  # Temperature inside at t=0.
temp_outside_t0 <- rnorm(testing.n, 60, 25) # Temperature outside at t=0.
sensor_t0       <- temp_t0 + rnorm(1, 0, 5) # Thermostat reading at t=0.

temp_t1         <- temp_t0                  # Temperature inside at t-1.
                   + ((temp_outside_t0 - temp_t0) * 0.2)
                   + rnorm(1, 0, 5)
temp_outside_t1 <- temp_outside_t0 + rnorm(1, 0, 5)
sensor_t1       <- temp_t1 + rnorm(1, 0, 5) # Thermostat reading at t=0.

temp_t2         <- temp_t1                  # Temperature inside at t-1.
                   + ((temp_outside_t1 - temp_t1) * 0.2)
                   + rnorm(1, 0, 5)
temp_outside_t2 <- temp_outside_t1 + rnorm(1, 0, 5)
sensor_t2       <- temp_t2 + rnorm(1, 0, 5) # Thermostat reading at t=0.

temp_t3         <- temp_t2                  # Temperature inside at t-1.
                   + ((temp_outside_t2 - temp_t2) * 0.2)
                   + rnorm(1, 0, 5)

d <- data.frame(cbind(temp_t0,
                      temp_t1,
                      temp_t2,
                      temp_t3,
                      sensor_t0,
                      sensor_t1,
                      sensor_t2,
                      temp_outside_t0,
                      temp_outside_t1,
                      temp_outside_t2
                      ))

model = list(name  = "temp",
             graph = g,
             data  = intervalScale(d))

class(model) <- "model"
models[[length(models) + 1]] <- model

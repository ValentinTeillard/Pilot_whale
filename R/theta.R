### spline curves with their CI
theta <- function(df, var_name, gam_model, unlog = TRUE) {
  # df: original dataset used to fit the model
  # var_name: vector of explanatory variable names used in the md
  # gam_model is dsm model you want to use
  # set unlog to TRUE to obtain curves on the density/abundance scale
  lower <- function(x) {
    as.numeric(coda::HPDinterval(coda::as.mcmc(x), prob = 0.95)[1])
  }
  upper <- function(x) {
    as.numeric(coda::HPDinterval(coda::as.mcmc(x), prob = 0.95)[2])
  }
  nx <- 1e3
  n_sim <- 1e4
  X <- as.data.frame(sapply(var_name, function(id) {
    rep(mean(df[, id]), nx)
  }))
  Y <- NULL
  for (j in var_name) {
    Z <- X
    Z[, j] <- seq(min(df[, j]), max(df[, j]), length.out = nx)
    Z <- predict(gam_model, newdata = Z, off.set = 1, type = "lpmatrix")
    beta <- mvtnorm::rmvnorm(n_sim, mean = gam_model$coefficients,
                             sigma = gam_model$Vc)
    linpred <- beta %*% t(Z)
    rm(Z, beta)
    if (unlog) {
      linpred <- exp(linpred)
    }
    Y <- rbind(
      Y,
      data.frame(
        x = seq(min(df[, j]), max(df[, j]), length.out = nx),
        y = apply(linpred, 2, mean),
        lower = apply(linpred, 2, lower),
        upper = apply(linpred, 2, upper),
        param = rep(j, nx)
      )
    )
  }
  return(Y)
}
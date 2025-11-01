fit_1GAM <- function(x, family, dat2fit) {
  # i=3
  # x <- all_md[i]
  switch(family,
         negative_binomial = {
           model <- gam(as.formula(x), data = dat2fit,
                        offset = log(dat2fit$sampling_e),
                        family = nb(link = "log"), method = "REML")
         },
         poisson = {
           model <- gam(as.formula(x), data = dat2fit,
                        offset = log(dat2fit$sampling_e),
                        family = poisson(link = "log"), method = "REML")
         },
         tweedie = {
           model <- gam(as.formula(x), data = dat2fit,
                        offset = log(dat2fit$sampling_e),
                        family = tw(link = "log"), method = "REML")
         },
         { # else!
           print("Enter a valid family distribution: negative_binomial,
            poisson or tweedie ")
         }
  )
  
  ### store some results in a data frame
  fit <- data.frame(
    model = x,
    Convergence = ifelse(model$converged, 1, 0),
    AIC = model$aic,
    GCV = model$gcv.ubre,
    ResDev = model$deviance,
    NulDev = model$null.deviance,
    ExpDev = 100 * round(1 - model$deviance / model$null.deviance, 3)
  )
  return(fit)
}
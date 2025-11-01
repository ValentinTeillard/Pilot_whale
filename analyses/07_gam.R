# model 1 to 3 variables

# # Run the models - WARNING - takes a long time to run
t <- system.time({
  all_fits <- lapply(all_md_13, fit_1GAM, family, eff2fit)
})
t

all_fits <- do.call(rbind, all_fits)
save(all_fits, file = "./data/all_fits.RData")
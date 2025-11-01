# model 4_1

# # Run the models - WARNING - takes a long time to run
t <- system.time({
  all_fits_1 <- lapply(all_md4_1, fit_1GAM, family, eff2fit)
})
t

all_fits_1 <- do.call(rbind, all_fits_1)
save(all_fits_1, file = "./data/all_fits_1.RData")
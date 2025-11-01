# model 4_3

# # Run the models - WARNING - takes a long time to run
t <- system.time({
  all_fits_3 <- lapply(all_md4_3, fit_1GAM, family, eff2fit)
})
t

all_fits_3 <- do.call(rbind, all_fits_3)
save(all_fits_3, file = "./data/all_fits_3.RData")
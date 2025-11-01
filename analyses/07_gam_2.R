# model 4_2

# # Run the models - WARNING - takes a long time to run
t <- system.time({
  all_fits_2 <- lapply(all_md4_2, fit_1GAM, family, eff2fit)
})
t

all_fits_2 <- do.call(rbind, all_fits_2)
save(all_fits_2, file = "./data/all_fits_2.RData")
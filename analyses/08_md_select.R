# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#################      md selection     #################
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

rm(all_md, all_md_13, all_md4, all_md4_1, all_md4_2, all_md4_3, ind_n_obs,
   n, t, rasters, split_indices, res)

# load all ("all_fits_ord.R")
load("./data/all_fits.RData")
load("./data/all_fits_1.RData")
load("./data/all_fits_2.RData")
load("./data/all_fits_3.RData")

# create a single data frame
all_fits_t <- rbind(all_fits, all_fits_1, all_fits_2, all_fits_3)

# Le poids de chaque covariable à été évaluée en utilisant le nombre de fois
# où cette dernière apparaît dans les combinaisons de model, pondéré par
# “l’Akaike weight” du model.
all_fits_ord <- AIC_weights(all_fits_t)
save(all_fits_ord, file="./data/all_fits_ord.RData")

head(all_fits_ord)

# calculate the importance of each variables based on akaike weight
importance_var(envdata, all_fits_ord)

# we choose the 3 first model 
# it contain the same vars as the first 4 important variables 

fit_1 <- gam(as.formula(as.character(all_fits_ord[1, 1])),
           data = eff2fit, offset = log(eff2fit$sampling_e),
           family = nb(link = "log"), method = "REML")

fit_2 <- gam(as.formula(as.character(all_fits_ord[2, 1])),
             data = eff2fit, offset = log(eff2fit$sampling_e),
             family = nb(link = "log"), method = "REML")

fit_3 <- gam(as.formula(as.character(all_fits_ord[3, 1])),
             data = eff2fit, offset = log(eff2fit$sampling_e),
             family = nb(link = "log"), method = "REML")


plot_smooth_GAM(fit_1, eff2fit)
plot_smooth_GAM(fit_2, eff2fit)
plot_smooth_GAM(fit_3, eff2fit)

#-------------------------------------------------------------------------------

rm(all_fits, all_fits_1, all_fits_2, all_fits_3, all_fits_t)


#### Checking the first k models
#first_k_md(k, all_fits_ord, family, eff2fit, "./figures")
# a retirer des fonctions R ou a modifier 
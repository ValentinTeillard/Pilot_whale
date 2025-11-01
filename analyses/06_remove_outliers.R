# 6. Removing outliers of the environmental variables -----

# Removing outliers of the environ va (grid) to predict with the z score method
# Removing the 0.3% of the distribution tail of environmental va
# (so we work with the 99.7% of the distribution)
out <- find_outliers_z_score(eff2fit)
eff2fit <- out$effort2fit #### enlever out!!!
# How many obs am I missing?? (the normalized values >3)
obs_outlier <- out$obs_outlier
sum(eff2fit$n_obs) # 26
table(eff2fit$n_obs)

out <- find_outliers_z_score(env_va)
env_va <- out$effort2fit


#-------------------------------------------------------------------------------
rm(out)
print(c("---------------------------------------------------------------------",
        "obs_outlier = The lines with n_obs > 0 that contain outliers in the env var",
        "eff2fit = sp_eff without NA,the 0 effort data and the outliers",
        "env_va = sp_eff without NA and outliers",
        "---------------------------------------------------------------------"))

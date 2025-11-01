#############   5. Removing NA of the data to fit the model ----

sp_eff$stat_sum <- NULL

# NA
# Returning a data frame with all the data (obs, env_var, effort)
# inside the sampled effort without NA
out <- effort_2fit_md_no_NA(sp_eff)

eff2fit <- out$effort2fit # sp_eff without NA and without the 0 effort data
obs_with_NA <- out$ind_NA # sightings with NA in env var 
env_va <- out$env_va # sp_eff without NA 

# How many obs do I have and am I missing??
sum(eff2fit$n_obs) # the obs i have
table(eff2fit$n_obs)

# where??
dat2look <- sp_eff[obs_with_NA, ]
sum(dat2look$n_obs) # the obs i am missing
# keep in mind the environmental variables that make you lose your obs when
# fitting the model!
# If they are not significant, it's worth it to run it again without
# this variable (so adding the missing data!)

#-------------------------------------------------------------------------------
rm(out, obs_with_NA)
print(c("---------------------------------------------------------------------",
        "dat2look = The lines with n_obs > 0 that contain NA in the env var",
        "eff2fit = sp_eff without NA and without the 0 effort data",
        "env_va = sp_eff without NA",
        "---------------------------------------------------------------------"))

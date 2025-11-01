# Return a data frame with all the data (obs, env_var, effort)
# inside the sampled effort without outliers

find_outliers_z_score <- function(x) {
  # x <- eff2fit
  # Selecting only the environmental columns
  ind_n_obs <- which(names(x) == "n_obs")
  env_va <- as.data.frame(x[, (ind_n_obs + 1):dim(x)[2]])
  # normalizing the data
  z_scores <- apply(X = env_va, MARGIN = 2, FUN = function(x) {
    return(abs((x - mean(x)) / sd(x)))
  })
  
  # sum the the number of times there was an outlier in the env va
  out <- rowSums(z_scores > 3)
  sp_eff <- cbind(x, out)
  # Selectiong only where there is no outliers in any environmental va
  sp_eff_out <- sp_eff[which(out == 0), ]
  # sp_eff_out <- sp_eff[!out,]
  
  # Where are we loosing observations with the NA?
  dat_score <- cbind(x[, 1:ind_n_obs], z_scores)
  obs_outlier <- dat_score[out > 0 & x$n_obs > 0, ]
  
  # Deeting the column "out"
  sp_eff_out <- subset(sp_eff_out, select = -c(out))
  
  return(list(effort2fit = sp_eff_out, obs_outlier = obs_outlier))
}
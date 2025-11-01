# Return a data frame with all the data (obs, env_var, effort)
# inside the sampled effort without NAs

effort_2fit_md_no_NA <- function(sp_effort) {
  # x_eff <- as.data.frame(sp_eff)
  # # Checking the NA of the data
  # any(is.na(sp_eff$sampling_e))
  x_eff <- as.data.frame(sp_effort)
  names_va <- names(x_eff)
  # where are NA in our data?
  # We add the NA positions of each explanatory variable
  range(unique(which(is.na(x_eff))))
  ind2del <- c()
  ind_n_obs <- which(names(x_eff) == "n_obs")
  for (i in (ind_n_obs + 1):dim(x_eff)[2]) {
    ind2del <- c(ind2del, which(is.na(x_eff[, i])))
  }
  # Where are we loosing observations with the NA?
  ind_obs <- which(x_eff$n_obs > 0) # line number where > 0
  ind_obs_NA <- c() # new variable
  for (i in 1:length(ind_obs)) {
    line <- x_eff[ind_obs[i], (ind_n_obs + 1):dim(x_eff)[2]]
    if (any(is.na(line))) {
      ind_obs_NA <- c(ind_obs_NA, ind_obs[i])
    }
  }
  # print("index of obs where there is some NA in the environmental va:")
  # print(unique(ind_obs_NA))
  # deleting all index with NA
  x_eff <- x_eff[-unique(ind2del), ]
  # Return only the grid cells that were sampled with no NA to fit the model =)
  x_eff2fit <- x_eff[-which(x_eff$sampling_e == 0), ]
  # dat2look <- sp_eff[ind_NA,]
  return(list(effort2fit = x_eff2fit, ind_NA = unique(ind_obs_NA),
              env_va = x_eff))
}
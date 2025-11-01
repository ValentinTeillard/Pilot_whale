poss_mod <- function(envdata, complexity, nb_max_xi_va, corr_thr) {
  # Names of the explanatory va
  predictors <- names(envdata)
  # design matrix with the explanatory variables for the md
  X <- envdata[, predictors]
  
  ## List of all combinations of all possible models among nb_max_pred
  # [[1]] : possible modeles with 1 explanatory variable  -> 18  
  # number of env va for Mn
  # [[2]] : possible modeles with 2 explanatory variables -> 153
  # so on until 4
  ## Total of possible models (Mn: 18+153+816+3060 = 4047!!)
  all_comb_md <- lapply(1:nb_max_xi_va, combn, x = length(predictors))
  
  ###### Creating a char vector with the names of all model combinations
  
  # writing the smooth terms of the md
  #   k: dim of the basis (smooth complexity)
  #   bs: base used to fit the smooth terms
  # ("tp" -- thin-plate splines) default method!
  # writeLines("using gam() with thin-plate splines")
  smoothers <- paste("s(", predictors, ", k = ", complexity, ", bs = 'tp'", ")",
                     sep = "")
  intercept <- "~ 1"
  all_md <- c(
    paste(outcome, intercept, sep = " "),
    unlist(lapply(1:nb_max_xi_va, FUN = all_md_list, y = outcome,
                  predictors = smoothers, intercept))
  )
  
  ###### Evaluating the cross-correlation (Pearson)
  
  # Creating a vector with the max linear correlation
  # obtained by a mod combination
  # of all the two explanatory va
  
  # Md with only 1 explanatory va:
  if (nb_max_xi_va == 1) {
    # No correlation between two va is the mod only have one!
    max_corr_per_all_md_comb <- c(rep(0, length(predictors) + 1))
    # +1 accounting for the md with only intercept (beta_0)
  } else { ## there are more than 1 explanatory va
    list_max_corr_by_md_comb <- lapply(X = all_comb_md[-1],
                                       FUN = max_corr_all_md_comb_with_iexp_va,
                                       X)
    # Adding the no-correlation for the md with only 1va and vectorizing
    # the max correlation for all the md combinations
    max_corr_per_all_md_comb <- c(c(rep(0, length(predictors) + 1)),
                                  unlist(list_max_corr_by_md_comb))
  }
  
  # print(max_corr_per_all_md_comb[1:300])
  
  ###### Deleting the md combinations of variables that are too correlated
  
  ## remove mod which explanatory va are more correlated than our threshold
  all_md <- all_md[which(max_corr_per_all_md_comb < corr_thr)]
  
  # suppress warnings
  options(warn = -1)
  return(all_md)
}
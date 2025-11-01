max_corr_per_1md_comb <- function(i, mat, X) {
  # Calculating the correlation matrix
  rho <- cor(X[, mat[, i]], use = "complete.obs")
  diag(rho) <- 0
  # Taking the maximum correlation between all pairs of explanatory va
  # inside the model
  max_corr <- max(abs(as.numeric(rho)))
  return(max_corr)
}
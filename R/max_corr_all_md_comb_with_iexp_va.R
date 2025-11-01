max_corr_all_md_comb_with_iexp_va <- function(mat, X) {
  # mat <- all_comb_md[[2]]
  return(sapply(seq_len(ncol(mat)), FUN = max_corr_per_1md_comb, mat, X))
}
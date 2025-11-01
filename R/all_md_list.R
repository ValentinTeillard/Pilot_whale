all_md_list <- function(n, y, predictors, intercept) {
  paste(y, apply(X = combn(predictors, n), MARGIN = 2, paste, collapse = " + "),
        sep = paste(intercept, "+", sep = " ")
  )
}
check_if_smooth <- function(var, smooth_vas) {
  # var <- VN[1]
  if (!any(grepl(var, smooth_vas, fixed = TRUE))) {
    # The var is NOT a smooth term
    return(no_smooth = var)
  }
}
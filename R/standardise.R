standardise <- function(x) {
  return((x - mean(x)) / sd(x))
}
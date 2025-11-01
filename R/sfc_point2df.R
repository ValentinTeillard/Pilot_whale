# transforming the geometry points coordinates (z) in a df of coordinates

sfc_point2df <- function(z) {
  matrix <- matrix(unlist(z, use.names = FALSE), nrow = length(z), byrow = TRUE,
                   dimnames = list(1:length(z)))
  df <- as.data.frame(matrix)
  colnames(df) <- c("x", "y")
  return(df)
}
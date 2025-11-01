# extracting the environmental value of the point central of each cell

env_var_par_MP_cell <- function(sp_eff, rasters) {
  # estimating the middle point of cells
  # suppress warnings
  options(warn = -1)
  centers <- st_centroid(sp_eff)
  # ON again warnings
  options(warn = 0)
  # transforming the geometry points coordinates (z) in a data frame
  coord_central <- sfc_point2df(centers$geometry)
  # extracting the environmental variables a the center of each grid geometry
  # removing the package "tidyr" because a problem with the function extract
  #(tidyr vs raster package)
  # rs.unloadPackage("tidyr")
  raster_name <- gsub("\\..*", "", rasters)
  for (i in 1:length(raster_name)) {
    sp_eff[[raster_name[i]]] <- raster::extract(get(raster_name[i]),
                                                coord_central, sp = TRUE)
  }
  return(sp_eff)
}
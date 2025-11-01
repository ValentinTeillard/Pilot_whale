# 3. Counting the number of sightings for each cell of the grid ----

# transforming the data coordinates and the effort in geo-referenced points ----
sp_points <- pw %>% st_as_sf(coords = c("longitude", "latitude"), crs = 4326,
                              remove = FALSE, na.fail = TRUE)

# giving the 4326 projection to the effort shape file ----
st_crs(sp_eff) <- 4326
sp_eff <- st_transform(sp_eff, crs = 4326)

# Correcting the possible geometry errors ----
sp_eff <- st_make_valid(sp_eff) 

# counting the number of points in each grid geometry (cell) ----
sp_eff$n_obs <- lengths(st_intersects(sp_eff, sp_points))

# checking we have all the obs ----
result1 <- paste("Total number of pilot whale sightings =", sum(sp_eff$n_obs))
print(result1)
print(table(sp_eff$n_obs))
print(c("New variable in sp_eff : n_obs = number of sightings for each cell of the grid"))
rm(result1, sp_points)

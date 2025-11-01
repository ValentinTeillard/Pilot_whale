#############   4. Adding the environmental data ----

# loading the raster of the environmental data ----
rasters <- dir("./data/rasters")
rasters

for (i in 1:length(rasters)) {
  load(paste(getwd(),"./data/rasters/",rasters[i], sep=""))
}

# extracting the environmental value of the point central of each cell
sp_eff <- env_var_par_MP_cell(sp_eff, rasters)


############# idea!! we could extract the mediane values in each cell ####
##### checking if taking another statistic as mean, median changes a lot...

#-------------------------------------------------------------------------------
# removing all the rasters to save space ;)
rm(list = gsub("\\..*", "", rasters))
rm(i)

# creer un super raster layer 
# creer un tableau recapitulatif
# creer une fonction pour plotter les var env

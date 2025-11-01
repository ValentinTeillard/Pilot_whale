# 2. loading the sampled effort on the grid from QGis ----

# downlaod the effort shapefile
sp_eff <- read_sf("./data/effort/sampling_effort", layer = "effort")

# The effort column needs to be named "sampling_e"
colnames(sp_eff)[which(colnames(sp_eff)=="effort")] <- "sampling_e"

# check the min and max to be sure its between 0 and 1
range(sp_eff$sampling_e)

# we assign the coordinates of the center of each grid cell
center <- st_centroid(sp_eff)
coord <- as.data.frame(st_coordinates(center$geometry))

sp_eff$center_lon <- coord$X
sp_eff$center_lat <- coord$Y

# plot_effort ----

shp = "./data/Antilles_n/Antilles_n.shp" # lesser antilles
LA <- st_read(shp, quiet = T)
shp = "./data/studyzone/studyzone_limits.shp" # study zone
studyzone <- st_read(shp, quiet = T)

# Calculer les ruptures naturelles
breaks <- classInt::classIntervals(sp_eff$sampling_e, n = 9, style = "fisher")
# Assigner les classes aux données
sp_eff$breaks <- findInterval(sp_eff$sampling_e, breaks$brks)
sp_eff$breaks <- sp_eff$breaks/10

plot_eff <- ggplot()+
  theme_classic()+
  theme(text = element_text(size = 15))+
  theme(plot.margin = margin(1, 1, 1, 1, "cm")) +
  ggtitle("")+
  geom_sf(data = sp_eff, aes(fill = factor(breaks)), color = "black", linetype = "blank") +
  scale_fill_viridis(discrete = T, option = "mako", name = "Effort") +  # Palette de couleurs
  geom_sf(data=LA, colour="black", fill="lightgrey")+
  coord_sf(crs = 4326)+
  geom_sf(data=studyzone, color="black", fill=NA)+
  lims(x = c(-64, -60), y = c(11.5, 19))+
  annotation_scale(location = "bl", width_hint = 0.4) +
  annotation_north_arrow(location = "tr", which_north = "true",
                         height = unit(1, "cm"), width = unit(1, "cm"),
                         pad_x = unit(0.1, "in"), pad_y = unit(0.1, "in"),
                         style = north_arrow_fancy_orienteering) +
  theme(legend.key.height= unit(1.5, 'cm'),legend.key.width= unit(0.25, 'cm'))+
  xlab("Longitude")+
  ylab("Latitude")

plot_eff

ggsave("./figures/sp_eff.pdf", plot = plot_eff, width = 21, height = 29.7,
       units = "cm")

sp_eff <- subset(sp_eff, select = -breaks)

#-------------------------------------------------------------------------------
rm(coord, center, LA, studyzone, breaks, shp)
print(c("---------------------------------------------------------------------",
        "sp_eff = data frame containing the effort of observation :",
        "- srfc_hx = surface of each hexagon of the grid",
        "- air_ttl = total area of the grid",
        "- id_grid = id associated to each cell of the grid",
        "- stat_sum =", 
        "- sampling_e = effort of observation",
        "- center_lon = longitude of the center of each grid",
        "- center_lat = latitude of the center of each grid",
        "---------------------------------------------------------------------"))

# Function for plotting prediction and CV
predbind <- function(x, y) {
  
  effort <- ggplot() +
    theme_classic()+
    theme(text = element_text(size = 17),
          legend.key.height = unit(1, 'cm'),
          legend.key.width = unit(0.25, 'cm'),
          axis.title.x = element_text(face = "bold"),
          axis.title.y = element_text(face = "bold"))+
    ggtitle(y) +
    geom_sf(data = x, aes(fill = fit), color=NA) +
    scale_fill_gradientn(colors = btr, na.value = "#F7FBFF", name = "") +
    geom_sf(data = LA, colour = "black", fill = "white", size=0.2) +
    coord_sf(crs = 4326) +
    lims(x = c(-64, -60), y = c(11.5, 19))+
    annotation_scale(location = "bl", width_hint = 0.4) +
    annotation_north_arrow(
      location = "tr", which_north = "true",
      height = unit(1, "cm"), width = unit(1, "cm"),
      pad_x = unit(0.1, "in"), pad_y = unit(0.1, "in"),
      style = north_arrow_fancy_orienteering
    ) +
    xlab("Longitude") +
    ylab("Latitude")
  
  return(effort)
}


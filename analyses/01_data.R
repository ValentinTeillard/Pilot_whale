#############   1. Loading data ----


# loading data pw ----
load("./data/pw.RData") # pw: pilot_whale obs presence only

pw <- pw[-c(7:8),]

# loading general data
load("./data/dat_full.RData") # dat_full: all the dataset
dat_full <- dat_full[-c(which(dat_full$type=="Whale watching")),]

# loading shapefiles ----

shp = "./data/Antilles_n/Antilles_n.shp" # lesser antilles
LA <- st_read(shp, quiet = T)
shp = "./data/studyzone/studyzone_limits.shp" # study zone
studyzone <- st_read(shp, quiet = T)
shp = "./data/effort/cutlines/cutlines.shp"
cutlines <- st_read(shp, quiet = T) # boat tracking


# plot studyzone + boat tracking ----

plot_boat <- ggplot()+
  theme_classic()+
  theme(text = element_text(size = 17))+
  theme(plot.margin = margin(1, 1, 1, 1, "cm")) +
  ggtitle("")+
  geom_sf(data=studyzone, colour="lightblue", fill="lightblue")+
  geom_sf(data=LA, colour="black", fill="lightgrey")+
  geom_sf(data=cutlines, aes(geometry=geometry), color="navyblue", size=5)+
  coord_sf(crs = 4326)+
  lims(x = c(-64, -60), y = c(11.5, 19))+
  annotation_scale(location = "bl", width_hint = 0.4) +
  annotation_north_arrow(location = "tr", which_north = "true",
                         height = unit(1, "cm"), width = unit(1, "cm"),
                         pad_x = unit(0.1, "in"), pad_y = unit(0.1, "in"),
                         style = north_arrow_fancy_orienteering) +
  theme(legend.key.height= unit(1.5, 'cm'),legend.key.width= unit(0.25, 'cm'))+
  xlab("Longitude")+
  ylab("Latitude")

plot_boat
ggsave("./figures/plot_boat.pdf", plot = plot_boat, width = 21, height = 29.7,
       units = "cm")

# plot studyzone + pilot whale sightings ----


pwd <- pw
pwd$Sightings <- rep("CCS",dim(pwd)[1])
pwd <- pwd[c(4,10,12:16),]
dat$Sightings <- dat$Data_origin
dat$Sightings[which(dat$Sightings=="CCS")] <- "CCS with ID"

dat_ccs <- subset(dat, dat$Data_origin=="CCS")
dat_dswp <- subset(dat, dat$Data_origin=="DSWP")


plot_obs <- ggplot()+
  theme_classic()+
  theme(text = element_text(size = 17),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.key.height = unit(1, 'cm'),
        legend.key.width = unit(0.25, 'cm'),
        legend.spacing.y = unit(0.1, 'cm'),
        legend.title = element_text(face = "bold"), 
        legend.text = element_text(margin = margin(b = 0, t = 0))) +
  ggtitle("")+
  geom_sf(data=studyzone, colour="lightblue", fill="lightblue")+
  geom_sf(data=LA, colour="black", fill="lightgrey")+
  geom_point(data=pw[1,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[1,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[2,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[2,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[3,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[3,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[4,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[4,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[5,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[5,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[6,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[6,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[7,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[7,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[8,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[8,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[9,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[9,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[10,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[10,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[11,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[11,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[12,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[12,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[13,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[13,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[14,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[14,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[15,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[15,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[16,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[16,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[17,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[17,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[18,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[18,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[19,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[19,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[20,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[20,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[21,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[21,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[22,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[22,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[23,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[23,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[24,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[24,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  geom_point(data=pw[25,], aes(x = longitude, y = latitude), shape = 1, size=2.5, color="white") + 
  geom_point(data=pw[25,], aes(x = longitude, y = latitude), shape = 20, size=3.5, color="black") +
  

  #geom_point(data=pwd, aes(x = longitude, y = latitude, color=Sightings), shape = 17, size=2)+
 # geom_point(data=dat_dswp, aes(x = long, y = lat, color=Sightings), shape = 18, size=2)+
 # geom_point(data=dat_dswp, aes(x = long, y = lat, color=Sightings), shape = 23, size=2.1, fill="#E64A19", color="black", stroke=0.1)+
 # geom_point(data=dat_ccs, aes(x = long, y = lat), shape = 20, size=2.5, color="black") +
 # geom_point(data=dat_ccs, aes(x = long, y = lat, color=Sightings), shape = 20, size=2)+
  coord_sf(crs = 4326)+
  lims(x = c(-64, -60), y = c(11.5, 19))+
  annotation_scale(location = "bl", width_hint = 0.4) +
  annotation_north_arrow(location = "tr", which_north = "true",
                         height = unit(1, "cm"), width = unit(1, "cm"),
                         pad_x = unit(0.1, "in"), pad_y = unit(0.1, "in"),
                         style = north_arrow_fancy_orienteering) +
  #scale_color_manual(values = c("CCS with ID" = "#1E88E5",
   #                             "DSWP" = "#E64A19",
    #                            "CCS" = "#8B0000")) +
  xlab("Longitude")+
  ylab("Latitude")

plot(plot_obs)
ggsave("./figures/plot_obs.pdf", plot = plot_obs, width = 21, height = 29.7,
       units = "cm")


plot_gen <- grid.arrange(plot_boat, plot_obs, ncol = 2)  
ggsave("./figures/plot_gen.pdf", plot = plot_gen, width = 29.7, height = 21,
       units = "cm")

library(cowplot)

# Supposons que plot_boat est ton plot sans légende
plot_obs_noleg <- plot_obs + theme(legend.position = "none")


legend_right <- get_legend(
  plot_obs +
    theme(
      legend.position = "right",
      legend.text = element_text(size = 15),
      legend.title = element_text(size = 15, face="bold"),
      legend.key.size = unit(0.5, "cm"),      # plus petit symbole
      legend.spacing.y = unit(0.3, 'cm')      # espacement vertical
    )
)


# Assembler les deux cartes côte à côte
plots_side <- plot_grid(plot_boat, plot_obs_noleg, ncol = 2, align = "hv", axis = "tblr")

# Ajouter la légende en bas
final_plot <- plot_grid(plots_side, legend_right, ncol = 2, rel_widths = c(1, 0.15))
final_plot
plot_gen <- final_plot

ggsave("./figures/plot_gen.pdf", plot = plot_gen, width = 29.7, height = 21,
       units = "cm")

# ------------------------------------------------------------------------------

### creer un tableau recapitulatif des donnees (effort en distance et temps etc.)

recap <- dat_full %>% group_by(year, type, exp_number) %>% summarise(days = length(unique(Date_s)),
                                                                     start = min(Date_s),
                                                                     stop = max(Date_s))

## measuring the effort in term of time

# measuring the difference of time between the start and the end of each start and stop effort
hours <- dat_full %>% group_by(year, type, exp_number, exp) %>% summarise(hrs = Time[length(Time)]-Time[1])
# Convert in seconds and calculate the total period
ttl_time <- hours %>% group_by(year, type, exp_number) %>%
  summarise(Total_seconds = sum(period_to_seconds(hms(hrs)))) %>%
  pull(Total_seconds)

# Convert in HH:MM:SS format
effort_time <- seconds_to_period(ttl_time)
recap$effort_time <- effort_time

## measuring the effort in term of distance

# create a column with longitude and latitude
dat_full$position <- cbind(dat_full$longitude, dat_full$latitude)
# calculate the distance between each start and stop
dis <- dat_full %>% group_by(year, type, exp_number, exp) %>% summarise(dist = sum(distHaversine(position)))
# sum the distance for each expedition
dist <- dis %>% group_by(year, type, exp_number) %>% summarise(effort_km = sum(dist))
# save in the recap tab
recap$effort_km <- dist$effort_km/1000


effort_data <- recap
effort_data$effort_time <- as.character(effort_data$effort_time)
write_xlsx(effort_data, "outputs/effort_data.xlsx")

print(paste("total time of visual effort =", seconds_to_period(sum(ttl_time))))
print(paste("total distance of visual effort =", sum(recap$effort_km), "km"))



result <- dat_full %>% group_by(island, exp) %>%
  summarise(
    distance_by_exp = if (n() > 1) {
      sum(distHaversine(cbind(longitude, latitude)))
    } else {
      0
    },
    .groups = "drop"
  ) %>%
  group_by(island) %>%
  summarise(
    total_distance = sum(distance_by_exp),
    .groups = "drop"
  ) %>%
  arrange(desc(total_distance))

result$total_distance <- (result$total_distance*100)/sum(result$total_distance)
print(result)

mean(result$total_distance)
median(result$total_distance)
sd(result$total_distance)

#-------------------------------------------------------------------------------

# number of short finned pilot whale sightings per year
pw %>% group_by(year) %>% summarise(sightings=n())

# classification of sightings with other species
ceta <- subset(dat_full, name=="Cetaceans")
sightings <- ceta %>% group_by(species_name_fr) %>% summarise(count=n()) %>% arrange(desc(count))

# Sightings per islands
pw %>% group_by(island) %>% summarise(sightings=n())

min(pw$cet_est, na.rm=T)
max(pw$cet_est, na.rm=T)
mean(pw$cet_est, na.rm=T)
median(pw$cet_est, na.rm=T)
sd(pw$cet_est, na.rm=T)

#-------------------------------------------------------------------------------

rm("shp", "cutlines", "LA", "studyzone", "dis", "dist", "effort_data",
   "hours", "effort_time", "ttl_time")

print(c("---------------------------------------------------------------------",
        "dat_full = all the dataset", "pw = The pilot whale sightings dataset",
        "plot_boat = plot of the boat tracking in the study zone",
        "plot_obs = plot of the pilot whale sightings in the study zone",
        "recap = tab containing the effort informations, saved as effort_data in outputs",
        "---------------------------------------------------------------------"))



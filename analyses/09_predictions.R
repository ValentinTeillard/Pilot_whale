# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#################      Predictions      #################
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

mod <- fit
head(envdata)

var <- as.character(mod$pred.formula[2]) # model formula
nvar <- names(envdata) # all environmental variables
wvar <- which(str_detect(var, nvar)) 

pre <- sp_eff[, c(1:8, (wvar+8))] 
#pre <- na.omit(pre)
dat_pred <- pre[, c(9:12)] ### variables selected in the best model
coord_pred <- pre[, 1:8]


# Density prediction
pred <- predict(mod, newdata = dat_pred, type = "response", se.fit = TRUE)

fit_corr <- pred$fit
bind <- cbind(st_as_sf(pre) %>% st_transform(4326), fit = fit_corr)
bind <- cbind(bind, cv = pred$se.fit / bind$fit)
#bind <- na.omit(bind)

# calculate CV of prediction
fit <- pred$se.fit / bind$fit # CV = standard error / prediction
bind.cv <- cbind(st_as_sf(pre) %>% st_transform(4326), fit)
bind.cv <- na.omit(bind.cv)
class(pre)

## plot of the prediction ----
shp = "./data/Antilles_n/Antilles_n.shp" # lesser Antilles
LA <- st_read(shp)
btr <- paletteer_c("grDevices::Zissou 1", 30)


jpeg(filename = "./figures/Predict_PW.jpeg", width = 2064,
     height = 1650, units = "px", quality = 100, res = 300)
a <- predbind(x = bind, y = "Prediction (ind/10km²)")
plot(a)
dev.off()

jpeg(filename = "./figures/CV_PW.jpeg", width = 2064,
     height = 1650, units = "px", quality = 100, res = 300)
b <- predbind(x = bind.cv, y = "Coefficient of variation")
plot(b)
dev.off()

jpeg(filename = "./figures/Predict_all.jpeg", width = 3800,
     height = 2000, units = "px", quality = 100, res = 300)
ggpubr::ggarrange(a, b, nrow = 1, ncol = 2)
# annotate_figure(plot, top = text_grob("Short-finned pilot whale",
# color = "black", face = "bold", size = 14))
dev.off()

#-------------------------------------------------------------------------------

rm(a, b, LA, mod, pre, pred, btr, fit, nvar, wvar, var, shp)

### coefficient of determination ####

# Comparison between the average prediction obtained from the models that 
# explained 80% of the total Akaike weight and the prediction obtained from the
# model fitted to the four most important variables

# Je vois que mes 3 premiers modèles ont un akaike weight somme > 99%
sum(all_fits_ord$Akaike.weight[1:3])

# je vais donc faire une prediction pour ces 3 modèles

# prediction pour le modele 1
mod <- fit_1

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
bind <- cbind(bind, se = pred$se.fit)
#bind <- na.omit(bind)

# calculate CV of prediction
fit <- pred$se.fit / bind$fit # CV = standard error / prediction
bind.cv_1 <- cbind(st_as_sf(pre) %>% st_transform(4326), fit)


bind_1 <- bind

# prediction pour le modele 2
mod <- fit_2

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
bind <- cbind(bind, se = pred$se.fit)
#bind <- na.omit(bind)

# calculate CV of prediction
fit <- pred$se.fit / bind$fit # CV = standard error / prediction
bind.cv_2 <- cbind(st_as_sf(pre) %>% st_transform(4326), fit)

bind_2 <- bind

# prediction pour modele 3
mod <- fit_3

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
bind <- cbind(bind, se = pred$se.fit)
#bind <- na.omit(bind)

# calculate CV of prediction
fit <- pred$se.fit / bind$fit # CV = standard error / prediction
bind.cv_3 <- cbind(st_as_sf(pre) %>% st_transform(4326), fit)

bind_3 <- bind

###----------------------------------------------------------------------------

aw1 <- all_fits_ord$Akaike.weight[1]
aw2 <- all_fits_ord$Akaike.weight[2]
aw3 <- all_fits_ord$Akaike.weight[3]

# Calcul de la moyenne pondérée des prédictions
weighted_fit <- (aw1 * bind_1$fit + aw2 * bind_2$fit + aw3 * bind_3$fit) / (aw1 + aw2+ aw3)

weighted_cv <- (aw1 * bind.cv_1$fit + aw2 * bind.cv_2$fit + aw3 * bind.cv_3$fit) / (aw1 + aw2+ aw3)


bind_1$fit_mean <- weighted_fit
bind_1$cv_combined <- weighted_cv


# bind 

bind_1$fit_mean <- rowMeans(cbind(bind_1$fit, bind_2$fit, bind_3$fit), na.rm = TRUE)


# Modèle de régression linéaire
model <- lm(bind_1$fit ~ bind_1$fit_mean)

# Calcul du R²
r_squared <- summary(model)$r.squared

x11
# Création du graphique
plot(bind_1$fit_mean, bind_1$fit, 
     xlab = "Mean prediction", 
     ylab = "Best model prediction", 
     main = paste("Best model prediction vs Mean prediction (R² =", round(r_squared, 3), ")"),
     pch = 19, col = "black")

# Ajout de la droite de régression
abline(model, col = "red", lwd = 2)

#----------- plot pred moyenne
shp = "./data/Antilles_n/Antilles_n.shp" # lesser Antilles
LA <- st_read(shp)
btr <- paletteer_c("grDevices::Zissou 1", 30)

bind_m <- bind_1
bind_m$fit <- bind_m$fit_mean
bind_m$fit <- bind_m$fit/max(bind_m$fit, na.rm=T)

jpeg(filename = "./figures/Predict_mean_PW.jpeg", width = 2064,
     height = 1650, units = "px", quality = 100, res = 300)
m <- predbind(x = bind_m, y = "")
plot(m)
dev.off()

bind.cv <- bind_m
bind.cv$fit <- bind_m$cv_combined

jpeg(filename = "./figures/CV_mean_PW.jpeg", width = 2064,
     height = 1650, units = "px", quality = 100, res = 300)
m.cv <- predbind(x = bind.cv, y = "")
plot(m.cv)
dev.off()


predict_all <- grid.arrange(m, m.cv, ncol = 2)

ggsave("./figures/predict_all.pdf", plot = predict_all, width = 29.7, height = 21,
       units = "cm")
# annotate_figure(plot, top = text_grob("Short-finned pilot whale",
# color = "black", face = "bold", size = 14))


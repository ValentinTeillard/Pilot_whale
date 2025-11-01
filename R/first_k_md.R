first_k_md <- function(k, all_fits_ord, family, eff2fit, saving.dat) {
  print(paste0("Plotting smooth functions of fit", k))
  
  switch(family,
         negative_binomial = {
           fit <- gam(as.formula(as.character(all_fits_ord$model[k])),
                      data = eff2fit,
                      offset = log(eff2fit$sampling_e),
                      family = nb(link = "log"), method = "REML"
           )
         },
         poisson = {
           fit <- gam(as.formula(as.character(all_fits_ord$model[k])),
                      data = eff2fit,
                      offset = log(eff2fit$sampling_e),
                      family = poisson(link = "log"), method = "REML"
           )
         },
         tweedie = {
           fit <- gam(as.formula(as.character(all_fits_ord$model[k])),
                      data = eff2fit,
                      offset = log(eff2fit$sampling_e),
                      family = tw(link = "log"), method = "REML"
           )
         },
         { # else!
           print("Enter a valid family distribution: negative_binomial,
            poisson or tweedie ")
         }
  )
  
  summary(fit)
  # plot_fit <- plot(fit, shade=TRUE, pages=1, shade.col="lightblue", rug=T)
  # par(mfrow=c(2,2))
  # gam.check(fit)
  
  #### Plotting smooth functions with their CI
  
  plot_name <- paste("fit", k, "_smooths_", family, ".jpeg", sep = "")
  plot_title <- paste("fit", k, " - family:", family, "   AIC= ",
                      round(all_fits_ord$AIC[k], 2),
                      "    ED = ", all_fits_ord$ExpDev[k], " %", sep = "")
  setwd(saving.dat)
  # solo lo guarda si hay 2 va (width = 2000)
  # si hay 3 va bien con width = 3000
  jpeg(filename = plot_name, width = 2000, height = 1350,
       units = "px", quality = 100, res = 300)
  # x11()
  plot_smooths(fit, eff2fit, limite = 10, plot_title)
  dev.off()
}
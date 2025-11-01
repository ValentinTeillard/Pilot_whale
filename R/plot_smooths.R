plot_smooths <- function(Mod, envdata, limite, titre) {
  # Mod <- fit
  # envdata <- eff2fit
  
  # Selecting the envionmental va names of the selected md
  var <- as.character(Mod$pred.formula[2])
  all_var <- names(envdata)
  ind_var <- which(str_detect(var, all_var))
  v_name <- all_var[ind_var]
  
  num_var <- length(v_name)
  
  data_smooth_fun <- lapply(X = 1:length(v_name), FUN = function(i) {
    return(data.frame(x = envdata[, ind_var[i]],
                      param = rep(v_name[i], length(envdata[, ind_var[i]]))))
  })
  data_smooth_fun <- do.call(what = rbind, args = data_smooth_fun)
  
  smooth_fun_plot <- lapply(X = list(Mod), FUN = theta,
                            df = envdata, var_name = v_name)
  smooth_fun_plot <- as.data.frame(do.call("rbind", smooth_fun_plot))
  pred <- (do.call("rbind", lapply(list(Mod), theta, df = envdata,
                                   var_name = v_name, unlog = TRUE)))
  pred$response <- c("relative density")
  
  theme_set(theme_bw(base_size = 18))
  gam_smooths <- ggplot(pred, aes(x = x, y = y), color = "midnightblue") +
    geom_hline(yintercept = exp(Mod$coefficients[1]),
               linetype = "dotted", color = "red") +
    geom_ribbon(aes(x = x, ymin = lower, ymax = upper),
                fill = "lightblue", color = "lightblue", alpha = 0.5) +
    geom_line(color = "midnightblue") +
    geom_rug(data = data_smooth_fun, aes(x = x), inherit.aes = FALSE) +
    facet_grid(response ~ param, scales = "free") +
    ylab("") +
    xlab("") +
    coord_cartesian(ylim = c(0, limite)) +
    ggtitle(titre) +
    theme(
      legend.position = "top",
      plot.title = element_text(lineheight = 0.8, face = "bold", size = 16),
      axis.text = element_text(size = 10),
      panel.grid.minor = element_blank(),
      panel.background = element_blank()
    )
  
  return(gam_smooths)
}
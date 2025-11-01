plot_smooth_GAM <- function(fit, eff2fit) {
  
  formula <- as.character(fit$formula)[3]
  split_va <- strsplit(formula, split = "bs =", fixed = TRUE)[[1]]
  smooth_vas <- split_va[grepl(", k = 4", split_va, fixed = TRUE)]
  VN <- names(fit$var.summary)
  
  if (length(smooth_vas) != length(VN)) {
    # Not all variables are smooth function
    # Maybe there is a linear term...
    # Selecting only the smooth's one (the function returns the NON smooth term)
    no_smooth <- unlist(lapply(X = VN, FUN = check_if_smooth, smooth_vas))
    # Updating only with the smooth covariates
    VN <- VN[-which(VN == no_smooth)]
  }
  
  n <- 200
  pd <- data.frame(row.names = 1:n)
  for (vn in VN) pd[[vn]] <- rep(mean(eff2fit[[vn]]), n)
  
  br <- gam.mh(fit)
  
  jpeg(filename = "./figures/smooth_functions.jpeg", width = 2000,
       height = 2000, units = "px", quality = 100, res = 300)
  # x11()
  par(mfrow = c(2, 2))
  for (vn in VN) {
    pd1 <- pd
    x <- pd1[[vn]] <- seq(min(eff2fit[[vn]]), max(eff2fit[[vn]]), length = n)
    X <- predict(fit, pd1, type = "lpmatrix")
    pv <- X %*% t(br$bs)
    # fv <- exp(apply(pv,1,quantile,prob=c(.025,.5,.975)))
    fv <- exp(apply(pv, 1, quantile, prob = c(.05, .5, .95)))
    # plot(x,fv[3,],type="n",xlab=vn,ylab="",ylim=c(0,max(fv)))
    plot(x, fv[3, ], type = "n", xlab = vn, ylab = "",
         ylim = c(0, max(fv[2, ] * 2)))
    polygon(c(x, x[n:1]), c(fv[3, ], fv[1, n:1]),
            col = "lightblue", border = NA)
    lines(x, fv[2, ])
    rug(eff2fit[, vn])
  }
  dev.off()
}
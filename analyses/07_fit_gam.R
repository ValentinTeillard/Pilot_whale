# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#################   Fitting the GAM md  #################
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Fitting was done via REML because is more robust to under smoothing,leading to
# fewer optimization issues and less variable estimates of smoothing parameters.
# The alternative methods, GCV and GCV.Cp, are prone to under-smoothing
# and hence, overfitting.
# reference : Wood, S. (2012, Oct 15). mgcv: Mixed GAM Computation Vehicle with
# GCV/AIC/REML smoothness estimation.
# https://www.tandfonline.com/doi/full/10.1080/01621459.2016.1180986

# To force relationships to be simple, focusing on the strongest effect
# and promote transferability,
# the degrees of freedom for model terms was limited to 4.


# Pour éviter un sur-ajustement, le nombre maximal de degrés de liberté
# (mesurés en nombre de nœuds k)
# autorisés pour les fonctions de lissage a été limité à k = 4 (Wood, 2006)

# INPUTS to fit the GAM
ind_n_obs <- which(names(eff2fit) == "n_obs")
# only the environmental variables
envdata <- eff2fit[, (ind_n_obs + 1):(dim(eff2fit)[2])]

# the data you want to predict (nb of sightings or nb of individuals)
family <- "tweedie" # family distribution must be one of "negative_binomial", "poisson" or "tweedie"
outcome <- "n_obs"
corr_thr <- 0.7 # maximum of correlation between variables
complexity <- 4 # smooth complexity
nb_max_xi_va <- 4 # number max of predictors


# # standardise data
# envdata[, predictors] <- apply(X, 2, standardise) # standardise on columns

# all possible md comb with a linear correlation between expl va |corr| < 0.7
all_md <- poss_mod(envdata, complexity, nb_max_xi_va, corr_thr)
nb_var <- str_count(all_md, "\\+") # permet de compter le nb de var dans all_md

# Plotting the correlation between the environment variables
res <- cor(envdata, method = "pearson", use = "complete.obs")
# Open a PDF device
pdf(file = "./figures/corvar.pdf", width = 8.27, height = 11.69)  # A4 dimensions in inches
# Generate the correlation plot
corrplot(res, type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)
# Close the device
dev.off()


#matrice_transforme <- ifelse(res < -0.7 | res > 0.7, res, 0)
#corrplot(matrice_transforme, type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)

# liste des combinaisons allant de 1 à 3 variables
all_md_13 <- all_md[which(nb_var<4)]

# liste des combinaisons a 4 variables
all_md4 <- all_md[which(nb_var==4)]

# Déterminer les indices pour diviser en 3 parties
n <- length(all_md4)
split_indices <- split(1:n, cut(1:n, breaks = 3, labels = FALSE))

# Diviser la liste en 3
all_md4_1 <- all_md4[split_indices[[1]]]
all_md4_2 <- all_md4[split_indices[[2]]]
all_md4_3 <- all_md4[split_indices[[3]]]


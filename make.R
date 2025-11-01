#' Pilot_whale
#' 
#' @description 
#' The goal of the following code is to predict the distribution of the short
#' finned pilot-whale in the Lesser Antilles.
#' It will use a species distribution model (Generalized Additive Model).
#' Multiple models will be run,
#' and the best model will be selected for making the prediction.
#' 
#' @author Valentin Teillard \email{valentin.teillard@gmail.com}
#' 
#' @date 2025/11/01


## Install Dependencies (listed in DESCRIPTION) ----
devtools::install_deps(upgrade = "never")

## Load Project Addins (R Functions and Packages) ----
devtools::load_all()

## Global Variables ----

# You can list global variables here (or in a separate R script)

## Run Project ----

# 0. loading all the libraries ----
source("analyses/00_setup.R")

# 1. Loading general data and plot maps ----
source("analyses/01_data.R")
plot_boat
plot_obs

# 2. loading the sampled effort on the grid ----
source("analyses/02_effort.R")
plot_eff

# 3. Counting the number of sightings for each cell of the grid ----
source("analyses/03_sightings.R")

# 4. Loading the environmental data ----
source("analyses/04_env_dat.R")
rasters

# 5. Removing NA of the data to fit the model ----
source("analyses/05_remove_na.R")
head(eff2fit)
dat2look

# 6. Removing outliers of the environmental variables ----
source("analyses/06_remove_outliers.R")
head(eff2fit)
obs_outlier # data > 3 are outliers

# 7. Enter the model parameters, create a list of all the combinations of
#    env var possible between 1 and 4 and run all this combinations ----
source("analyses/07_fit_gam.R")

# All the models are long to run so i divided it in 4 parts
source("analyses/07_gam.R") # the models with 1 to 3 variables
source("analyses/07_gam_1.R") # the 1st part of models with 4 var
source("analyses/07_gam_2.R") # the 2nd part of models with 4 var
source("analyses/07_gam_3.R") # the 3rd part of models with 4 var

# 8. select the best model and plot it ----
source("analyses/08_md_select.R")

# 9. Predict the distribution of pilot whale in the lesser antilles ----
source("analyses/09_predictions.R")

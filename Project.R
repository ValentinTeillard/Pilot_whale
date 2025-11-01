## Installation de 'rcompendium' ----
install.packages("rcompendium")

## Chargement du package -----
library("rcompendium")

## Stockage de vos informations ----
set_credentials(given    = "Valentin",
                family   = "Teillard", 
                email    = "valentin.teillard@gmail.com", 
                orcid    = "0000-0002-5243-3540", 
                protocol = "ssh")

## Vérification (après redémarrage de R) ----
options()$"email"

gh::gh_whoami()

## Ajout d'un fichier DESCRIPTION ----
add_description()

# add licence - choose with the following link
# https://choosealicense.com/

## Ajout d'une licence ----
add_license(license = "GPL-2")

## Ajout de sous-répertoires ----
add_compendium(compendium = c("data", "analyses", "R", "figures", "outputs"))

## Ajout de dépendances ----
devtools::document()

add_dependencies(compendium = ".")
usethis::use_namespace()


## Installation des packages manquants ----
remotes::install_deps(upgrade = "never")

## Chargement des packages et fonctions R ----
devtools::load_all()

## Ajout d'un makefile ----
add_makefile()

## Ajout d'un script R ----
utils::file.edit(here::here("analyses", ""))

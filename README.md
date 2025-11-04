# Pilot_whale

Author
- Valentin Teillard — https://github.com/ValentinTeillard
  
  * Enhydra msc bio : https://www.enhydramscbio.com/
  * Caribbean Cetacean Society : https://www.ccs-ngo.com/

Abstract

This repository contains the R code and analyses associated with the article “Spatial Ecology and Vulnerability of Short-finned Pilot Whales (Globicephala macrorhynchus) in the Lesser Antilles: Foundations for Conservation Planning” published in Marine Mammal Science. DOI: .
The objective is to provide a reproducible workflow for generating the results related to spatial modeling using Generalized Additive Models (figures, tables, outputs) presented in the associated article.

  **Repository Structure**

* **analyses/**        : Organized R analysis scripts (functions, pipelines)
* **code/**            : Reusable functions and main scripts (e.g., `run_analysis.R`, `utils.R`)
* **data/**            : Datasets (or a README with links if large)
* **figures/**         : Generated figures
* **outputs/**         : Results (tables, reports)
* **renv/** + **renv.lock** : Frozen R environment using *renv*
* **DESCRIPTION**, **NAMESPACE**, **.Rprofile**, **make.R** : R package / project files
* **.github/workflows/** : CI configuration (if present)
* **README.md**        : This file
* **LICENSE.md**       : Project license


Reproduction rapide (en local)
1. Cloner le dépôt :
   git clone https://github.com/ValentinTeillard/Pilot_whale.git
   cd Pilot_whale

2. Mettre à jour la branche principale :
   git checkout main
   git pull origin main

3. Restaurer l'environnement R (renv) :
   # dans R / RStudio
   install.packages("renv")
   renv::restore()  # restaure les versions de package depuis renv.lock

4. Lancer l’analyse principale
   - Si tu utilises un script principal (ex: make.R ou Project.R) :
     Rscript make.R
     ou
     R -e "source('Project.R')"
   - Ou ouvrir un RMarkdown dans analyses/ ou notebooks/ et knit (RStudio -> Knit) :
     Rscript -e "rmarkdown::render('notebooks/reproduce_analysis.Rmd')"

Conseils pratiques
- renv: garde renv.lock à jour après ajout/suppression de packages (renv::snapshot()).
- Ne commite pas de données sensibles : si les jeux sont volumineux (>100 MB) utilise Git LFS ou un dépôt/plateforme externe (Zenodo, figshare).
- Ajouter un CITATION.cff pour indiquer comment citer le code (je peux le générer pour toi).
- Pour figer une version publiée : crée une release GitHub (ex. v1.0.0) et connecte-toi à Zenodo pour obtenir un DOI.

Licence
- Voir LICENSE.md (actuellement présente dans le repo). Vérifie que la licence convient au code et aux données.

Contact / Support
Pour toute question sur la reproductibilité ou l’organisation du dépôt, ouvre une Issue sur GitHub ou contacte-moi : https://github.com/ValentinTeillard

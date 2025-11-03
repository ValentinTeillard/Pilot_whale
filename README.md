# Pilot_whale

Auteurs
- Valentin Teillard — https://github.com/ValentinTeillard

Résumé
Ce dépôt contient le code et les analyses R associées au projet Pilot_whale. L’objectif est de fournir un workflow reproductible pour générer les résultats (figures, tables, outputs) utilisés dans l’article associé.

Structure du dépôt
- analyses/        : scripts d’analyse R organisés (fonctions, pipelines)
- code/            : fonctions réutilisables et scripts principaux (ex: run_analysis.R, utils.R)
- data/            : jeux de données (ou README avec liens si volumineux)
- figures/         : figures générées
- outputs/         : résultats (tables, rapports)
- renv/ + renv.lock: environnement R figé avec renv
- DESCRIPTION, NAMESPACE, .Rprofile, make.R : package / projet R
- .github/workflows/: CI (si présent)
- README.md        : ce fichier
- LICENSE.md       : licence du projet

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

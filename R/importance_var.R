importance_var <- function(envdata, all_fits_ord) {
  
  # Extraire les noms des variables environnementales à partir du jeu de données 'envdata'
  nam <- colnames(envdata)  # Liste des noms de colonnes (variables)
  
  # Créer un DataFrame 'imp' pour stocker les résultats : nom de la variable et son pourcentage d'importance
  imp <- data.frame(var = nam, pourcentage = rep(0, length(nam)))
  
  # Boucle pour calculer l'importance de chaque variable dans le modèle
  for (i in 1:length(nam)) {
    # Chercher les indices des modèles qui contiennent cette variable
    ind <- which(str_detect(all_fits_ord$model, nam[i]) == TRUE)
    
    # Calculer la somme des poids d'Akaike pour cette variable (en pourcentage)
    imp[i, 2] <- sum(all_fits_ord$Akaike.weight[ind]) * 100
  }
  
  # Trier les variables par ordre décroissant de leur importance
  imp_ord <- imp[order(imp$pourcentage, decreasing = TRUE), ]
  
  # Normaliser les pourcentages pour les ramener sur une échelle de 0 à 100 (en divisant par 400 ici)
  imp_ord$pourcentage <- imp_ord$pourcentage * 100 / 400
  
  # Ordonner les variables dans l'ordre croissant de l'importance pour le plot
  imp_ord$var <- factor(imp_ord$var, levels = imp_ord$var[order(imp_ord$pourcentage, decreasing = FALSE)])
  
  imp_ord2 <- subset(imp_ord, imp_ord$pourcentage>1)
  
  # Création du graphique avec ggplot
  p <- ggplot(imp_ord2, aes(x = pourcentage, y = var)) + 
    geom_bar(stat = "identity", width = 0.2, fill = "lightblue", col = "lightblue") +  # Barres orange représentant les importances
    #geom_point(stat = "identity", size = 2, fill = "lightblue", col = "lightblue") +  # Points bleus pour chaque variable
    expand_limits(x = max(imp_ord2$pourcentage) * 1.1) +  # Agrandir l'axe des X
    geom_text(aes(label = paste0(round(pourcentage, 1), "%")), 
              hjust = -0.2, size = 5.5) +  # Afficher les pourcentages arrondis à la première décimale
    labs(x = "Importance (%)", y = "Environmental variables")+  # Étiquettes des axes
    theme_minimal(base_size = 17) +  # Thème sobre et pro
    theme(
      plot.title = element_text(size = 16, face = "bold", hjust = 0.5),  # Centré
      axis.text.y = element_text(margin = margin(t = -6, b = -6)),  # resserre verticalement
      panel.grid.major.y = element_blank(),  # Retirer les lignes horizontales
      panel.grid.minor = element_blank(),
      #axis.ticks = element_blank()
      axis.title.x = element_text(face = "bold"),
      axis.title.y = element_text(face = "bold")
    )  
    
  print(p)
  
  # Enregistrer le plot sous forme de fichier JPEG dans le répertoire spécifié
  ggsave("./figures/importance_plot.jpeg", plot = p, width = 8, height = 6, dpi = 300)  # Enregistrer avec une résolution de 300 DPI
  
  # Enregistrer le DataFrame des résultats en fichier Excel
  output_excel <- file.path("./outputs/importance_data.xlsx")
  writexl::write_xlsx(imp_ord, output_excel)  # Utilisation de writexl pour sauvegarder en Excel
  
  # Enregistrer le DataFrame des résultats en fichier RData (format R)
  output_rdata <- file.path("./data/importance_data.RData")
  save(imp_ord, file = output_rdata)  # Enregistrer le DataFrame au format RData
  
  # Retourner le DataFrame imp_ord, ce qui permet d'examiner ou utiliser les résultats ailleurs
  return(imp_ord)
}

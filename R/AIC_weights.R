AIC_weights <- function(all_fits) {
  AIC_ord <- all_fits[order(all_fits$AIC), ] # we order the model by AIC
  aics <- akaike.weights(AIC_ord$AIC)
  
  ### delta AICs: AICi - AICmin
  AIC_ord$Delta.AIC <- aics$deltaAIC
  # < 2: modele tres probable # 4 - 7: modele moins probable
  # > 10: modele tres peu probable
  
  ### relative likelihood: exp((AICmin-AICi)/2)
  AIC_ord$rel.likelihood <- aics$rel.LL
  # exp((AICmin-AICi)/2)== vraisemblance relative du modele i
  
  ### Akaike weights: relative likelihood_i / sum(all relative likelihood)
  AIC_ord$Akaike.weight <- aics$weights
  # un poids de 0.65 indique que le modele a 65% de chance d'etre le meilleur
  # modele parmi tous ceux testes
  # si weight > 0.90, on utilise ce modele pour faire l'inference
  # si weight < 0.90, preferable de faire l'inference
  # a partir de tous les modeles
  return(AIC_ord)
}

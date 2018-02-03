library(Logolas)

mat <- get(load(system.file("extdata", "UMI.Rdata", package = "Logolas")))
logomaker(mat,  type = "Logo", colors = c("#ABDDA4","#FDAE61", "#2B83BA", "#D7191C"))

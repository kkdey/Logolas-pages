library(Logolas)
out <- get(load(system.file("extdata", "EBF1_disc1.RData",package = "Logolas")))
logomaker(EBF1_disc1, type = "EDLogo",
          color_type = "per_row", colors = c("#ABDDA4","#FDAE61", "#2B83BA", "#D7191C"))

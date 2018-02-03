library(Logolas)
library(grid)

pfm1=cbind(c(1,2,1,1),c(0,0,5,0),c(0,3,1,1),c(0,5,0,0),c(0,3,0,2),c(0,0,5,0),c(2,1,2,0),c(0,0,5,0),c(1,1,0,3))
rownames(pfm1)=c('A','C','G','T')
pfm2=cbind(c(1,9,5,5),c(1,16,2,1),c(1,1,18,0),c(1,0,2,17),c(18,1,0,1),c(1,18,0,0),c(1,2,16,1),c(6,4,7,3),c(2,12,1,5),c(8,5,5,2))
rownames(pfm2)=c('A','C','G','T')
pfm3=cbind(c(31,8,46,29),c(1,2,25,86),c(12,34,11,57),c(3,1,106,4),c(1,110,1,2),c(3,1,109,1),c(0,3,1,110),c(0,0,114,0),c(33,57,6,18))
rownames(pfm3)=c('A','C','G','T')

color_profile = list("type" = "per_row",
                     "col" = RColorBrewer::brewer.pal(4,name ="Spectral"))

get_viewport_logo(3, 2, heights_1 = 10)

seekViewport(paste0("plotlogo", 1))
logomaker(pfm1, type = "Logo", color_type = "per_row",  use_dash = FALSE,
          colors = c("#ABDDA4","#FDAE61", "#2B83BA", "#D7191C"),
          logo_control = list(newpage = FALSE))

seekViewport(paste0("plotlogo", 2))
logomaker(pfm1, type = "Logo", color_type = "per_row",  use_dash = TRUE,
          colors = c("#ABDDA4","#FDAE61", "#2B83BA", "#D7191C"),
          logo_control = list(newpage = FALSE))


seekViewport(paste0("plotlogo", 3))
logomaker(pfm2, type = "Logo", color_type = "per_row",  use_dash = FALSE,
          colors = c("#ABDDA4","#FDAE61", "#2B83BA", "#D7191C"),
          logo_control = list(newpage = FALSE))

seekViewport(paste0("plotlogo", 4))
logomaker(pfm2, type = "Logo", color_type = "per_row",  use_dash = TRUE,
          colors = c("#ABDDA4","#FDAE61", "#2B83BA", "#D7191C"),
          logo_control = list(newpage = FALSE))

seekViewport(paste0("plotlogo", 5))
logomaker(pfm3, type = "Logo", color_type = "per_row",  use_dash = FALSE,
          colors = c("#ABDDA4","#FDAE61", "#2B83BA", "#D7191C"),
          logo_control = list(newpage = FALSE))

seekViewport(paste0("plotlogo", 6))
logomaker(pfm3, type = "Logo", color_type = "per_row",  use_dash = TRUE,
          colors = c("#ABDDA4","#FDAE61", "#2B83BA", "#D7191C"),
          logo_control = list(newpage = FALSE))




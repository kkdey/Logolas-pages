
############  Supplementary figure  1   R code   #######################

########  Achn021211, Actinidia chinensis

http://planttfdb.cbi.pku.edu.cn/tf.php?sp=Ach&did=Achn021211

library(Logolas)

plant <- read.table("plant.txt")
colnames(plant) <- c("A", "C", "G", "T")
rownames(plant) <- 1:dim(plant)[1]


mat <- t(plant)

color_profile <- list("type" = "per_row",
                      "col" = RColorBrewer::brewer.pal(dim(mat)[1],name ="Spectral"))

logomaker(mat, xlab = 'position',color_profile = color_profile,
          frame_width = 1,
          bg=c(0.3141, 0.1859, 0.1859, 0.3141),
          pop_name = 'GC content based background prob',
          control = list(viewport.margin.left = 5))

logomaker(mat, xlab = 'position',color_profile = color_profile,
          frame_width = 1,
          pop_name = 'uniform background prob',
          control = list(viewport.margin.left = 5))


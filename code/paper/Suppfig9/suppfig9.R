

# http://planttfdb.cbi.pku.edu.cn/tf.php?sp=Ach&did=Achn021211

library(Logolas)

plant <- read.table("plant.txt")
colnames(plant) <- c("A", "C", "G", "T")
rownames(plant) <- 1:dim(plant)[1]


mat <- t(plant)

color_profile <- list("type" = "per_row",
                      "col" = RColorBrewer::brewer.pal(dim(mat)[1],name ="Spectral"))

logomaker(mat, xlab = 'position',color_profile = color_profile,
          frame_width = 1,
          pop_name = ' renyi entropy, alpha : 0.01',
          control = list(viewport.margin.left = 5, alpha = 0.01,
                         gap_ylab = 3.5),
          y_fontsize = 10)


logomaker(mat, xlab = 'position',color_profile = color_profile,
          frame_width = 1,
          pop_name = ' renyi entropy, alpha : 100',
          control = list(viewport.margin.left = 5, alpha = 100,
                         gap_ylab = 3.5),
          y_fontsize = 10)


logomaker(mat, xlab = 'position',color_profile = color_profile,
          frame_width = 1,
          pop_name = 'shannon entropy',
          control = list(viewport.margin.left = 5, gap_ylab = 3.5),
          y_fontsize = 10)

logomaker(mat, xlab = 'position',color_profile = color_profile,
          frame_width = 1,
          pop_name = 'bar chart',
          control = list(viewport.margin.left = 5, hist = TRUE,
                         gap_ylab = 3.5),
          y_fontsize = 10)



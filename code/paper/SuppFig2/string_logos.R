

###############    String Logo representation     ####################

library(Logolas)

set.seed(20)
suppressWarnings(suppressMessages(load(system.file("extdata", "himalayan_fauna_3_clusters.rda", package = "Logolas"))))
color_profile <- list("type" = "per_column",
                      "col" = sample(RColorBrewer::brewer.pal(10,name = "Spectral"),
                                     dim(himalayan_fauna_3_clusters)[2], replace=TRUE))
colnames(himalayan_fauna_3_clusters) <- c("Region1", "Region2", "Region3")
logomaker(himalayan_fauna_3_clusters,
          color_profile = color_profile,
          frame_width = 1,
          ic.scale = TRUE,
          pop_name = "Bird family composition across regions",
          xlab = "",
          ylab = "Information content",
          control = list(gap_xlab = 3))



library(Logolas)

mat <- rbind(c(326, 296, 81, 245, 71),
             c(258, 228, 55, 273, 90),
             c(145, 121, 29, 253, 85),
             c(60, 52, 23, 180, 53),
             c(150, 191, 63, 178, 63))
rownames(mat) <- c("H3K4ME1", "H3K4ME2", "H3K4ME3", "H3AC", "H4AC")
colnames(mat) <- c("Intergenic","Intron","Exon \n 1000 KB window",
                   "Gene start \n 1000 KB window","Gene end \n 1000 KB window")

color_profile <- list("type" = "per_row",
                      "col" = sample(RColorBrewer::brewer.pal(10,name = "Spectral"),
                                     dim(mat)[1]))
logomaker(mat,
          color_profile = color_profile,
          frame_width = 1,
          ic.scale = TRUE,
          pop_name = "Histone marks composition (Logo)",
          xlab = "",
          ylab = "Information content",
          yscale_change = TRUE,
          col_line_split = "black",
          control = list(gap_ylab = 3.5))


nlogomaker(mat,
           logoheight = 'log',
           color_profile = color_profile,
           frame_width = 1,
           xlab = "Position",
           pop_name = 'Histone marks composition (EDLogo)',
           control = list(epsilon=0.25,gap_ylab=3.5)
)


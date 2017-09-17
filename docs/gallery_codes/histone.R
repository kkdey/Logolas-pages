library(Logolas)

mat <- rbind(c(326, 296, 81, 245, 71),
             c(258, 228, 55, 273, 90),
             c(145, 121, 29, 253, 85),
             c(60, 52, 23, 180, 53),
             c(150, 191, 63, 178, 63))
rownames(mat) <- c("H3K4ME1", "H3K4ME2", "H3K4ME3", "H3AC", "H4AC")
colnames(mat) <- c("Intergenic","Intron","Exon nn 1000 KB window",
                   "Gene start nn 1000 KB window","Gene end nn 1000 KB window")

color_profile <- list("type" = "per_row",
                      "col" = sample(RColorBrewer::brewer.pal(10,name = "Spectral"),
                                     dim(mat)[1]))
logomaker(mat,
          color_profile = color_profile,
          frame_width = 1,
          ic.scale = TRUE,
          pop_name = "Histone marks in various genomic regions",
          xlab = "",
          ylab = "Information content",
          yscale_change = TRUE,
          col_line_split = "black",
          control = list(gap_ylab = 3.5))


mat <- rbind(c(326, 296, 81, 245, 71),
             c(258, 228, 55, 273, 90),
             c(145, 121, 29, 253, 85),
             c(60, 52, 23, 180, 53),
             c(150, 191, 63, 178, 63))

bgmat <- rbind(c(542, 218, 118, 108, 33),
               c(480, 204, 107, 87, 26),
               c(346, 131, 71, 66, 20),
               c(199, 72, 41, 43, 13),
               c(368, 101, 67, 80, 30))

rownames(mat) <- c("H3K4ME1", "H3K4ME2", "H3K4ME3", "H3AC", "H4AC")
colnames(mat) <- c("Intergenic","Intron","Exon",
                   "Gene start ","Gene end")

set.seed(181)
color_profile <- list("type" = "per_row",
                      "col" = sample(RColorBrewer::brewer.pal(10,name = "Spectral"),
                                     dim(mat)[1], replace = FALSE))


Logolas::nlogomaker(mat,
                    logoheight = 'log',
                    bg = bgmat,
                    color_profile = color_profile,
                    xlab = "Position",
                    pop_name = 'EDLogo : Histones',
                    control = list(epsilon=0.1,
                                   gap_ylab=3.5,
                                   round_off = 2,
                                   posbins = 3, negbins = 3))


library(Logolas)

set.seed(20)
suppressWarnings(suppressMessages(load(system.file("extdata", "himalayan_fauna_3_clusters.rda", package = "Logolas"))))
color_profile <- list("type" = "per_column",
                      "col" = sample(RColorBrewer::brewer.pal(10,name = "Spectral"),
                                     dim(himalayan_fauna_3_clusters)[2], replace=TRUE))
logomaker(himalayan_fauna_3_clusters,
          color_profile = color_profile,
          frame_width = 1,
          ic.scale = TRUE,
          pop_name = "Bird family abundance across clusters",
          xlab = "Clusters",
          ylab = "Information content",
          control = list(gap_xlab = 3))

library(Logolas)
mat <- get((load(system.file("extdata", "himalayan_fauna_3_clusters.rda", package = "Logolas"))))
logomaker(himalayan_fauna_3_clusters, type = "Logo", color_type = "per_column",
          colors = sample(RColorBrewer::brewer.pal(10,name = "Spectral"),
                          dim(himalayan_fauna_3_clusters)[2], replace=TRUE))

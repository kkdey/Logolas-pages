library(Logolas)
data(himalayan_fauna)
logomaker(himalayan_fauna, type = "Logo", color_type = "per_column",
          colors = sample(RColorBrewer::brewer.pal(10,name = "Spectral"),
                          dim(himalayan_fauna)[2], replace=TRUE))

library(Logolas)

suppressWarnings(suppressMessages(load(system.file("extdata", "count_table_19101.3.B12.AGCCACTT.L004.R1.C6WYKACXX.rda", package = "Logolas"))))
color_profile <- list("type" = "per_row",
                      "col" = RColorBrewer::brewer.pal(4,name ="Spectral"))

nlogomaker(mat,
           logoheight = 'log',
           color_profile = color_profile,
           frame_width = 1,
           xlab = 'UMI base position')
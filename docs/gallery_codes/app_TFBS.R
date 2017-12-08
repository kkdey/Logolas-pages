library(Logolas)
out <- suppressWarnings(suppressMessages(get(load(system.file("extdata", "EBF1.RData",
                                                              package = "Logolas")))))

color_profile = list("type" = "per_row",
                     "col" = RColorBrewer::brewer.pal(4,name ="Spectral"))
EBF1_disc1=t(out);rownames(EBF1_disc1)=c('A','C','G','T');colnames(EBF1_disc1)=1:ncol(EBF1_disc1)

nlogomaker(EBF1_disc1,logoheight = 'log',
           color_profile = color_profile,
           frame_width = 1,
           pop_name = 'Trasncription Factor (EBF1_disc1)')

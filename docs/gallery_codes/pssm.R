library(Logolas)
pssm <- get(load(system.file("extdata", "pssm.Rdata", package = "Logolas")))
cols1 <- c(rev(RColorBrewer::brewer.pal(12, "Paired"))[c(3,4,7,8,11,12,5,6,9,10)],
           RColorBrewer::brewer.pal(12, "Set3")[c(1,2,5,8,9)],
           RColorBrewer::brewer.pal(9, "Set1")[c(9,7)],
           RColorBrewer::brewer.pal(8, "Dark2")[c(3,4,8)])

logo_pssm(pssm, color_type = "per_row", colors = cols1,
          control = list(round_off = 0, quant = 0.5))

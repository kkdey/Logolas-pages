library(Logolas)
library(atSNP)
pfm_mk=LoadMotifLibrary('http://compbio.mit.edu/encode-motifs/motifs.txt',tag = ">",transpose = F, field = 1, sep = c("\t", " ", ">"), skipcols = 1, skiprows = 1, pseudocount = 0)
EBF1_disc1=t(pfm_mk[[52]]);rownames(EBF1_disc1)=c('A','C','G','T');colnames(EBF1_disc1)=1:10

color_profile <- list("type" = "per_row",
                      "col" = RColorBrewer::brewer.pal(4,name ="Spectral"))

nlogomaker(EBF1_disc1,logoheight = 'log',
           color_profile = color_profile,
           frame_width = 1,
           pop_name = 'Trasncription Factor (EBF1_disc1)')

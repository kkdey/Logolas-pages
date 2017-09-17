library(Logolas)
library(TFBSTools)
library(JASPAR2014)

opts3 = list()
opts3[['type']] = 'ChIP-seq'
PFMchip = getMatrixSet(JASPAR2014,opts3)

pfm=as.matrix(PFMchip[[121]])
rownames(pfm)=c('A','C','G','T')
colnames(pfm)=1:ncol(pfm)

color_profile <- list("type" = "per_row",
                      "col" = RColorBrewer::brewer.pal(4,name ="Spectral"))

nlogomaker(pfm,logoheight = 'log',xlab = 'position',
           color_profile = color_profile,frame_width = 1,
           control = list( log_epsilon =1, gap_ylab = 3.5))

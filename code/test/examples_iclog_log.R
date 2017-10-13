
#############  examples ic log, log for PWM matrices  ################

library(Logolas)
#read all the motif data from http://compbio.mit.edu/encode-motifs/motifs.txt
library(atSNP)
pfm=LoadMotifLibrary('http://compbio.mit.edu/encode-motifs/motifs.txt',tag = ">",
                     transpose = F, field = 1, sep = c("\t", " ", ">"), skipcols = 1, skiprows = 1,
                     pseudocount = 0)
color_profile = list("type" = "per_row",
                     "col" = RColorBrewer::brewer.pal(4,name ="Spectral"))
EBF1_disc1=t(pfm[[52]]);rownames(EBF1_disc1)=c('A','C','G','T');colnames(EBF1_disc1)=1:ncol(EBF1_disc1)
######################
#logo plot of EBF1
logomaker(EBF1_disc1,color_profile = color_profile,frame_width = 1,
          pop_name = 'EBF1_disc1 (Logo)')
#neg logo plot
#The log type negative logo plot does not look good


EBF1_disc1 <- cbind(c(0.30, 0.34, 0.34, 0.02), c(0.99, 0.003, 0.03, 0.04),
                    c(0.98, 0.01, 0.005, 0.005), c(0.33, 0.33, 0.33, 0.01),
                    c(0.01, 0.45, 0.45, 0.09))
rownames(EBF1_disc1) <- c("A", "C", "G", "T")
colnames(EBF1_disc1) <- 1:ncol(EBF1_disc1)


bgmat <- matrix(0.25, dim(EBF1_disc1)[1], dim(EBF1_disc1)[2])
rownames(bgmat) <- rownames(EBF1_disc1)
colnames(bgmat) <- colnames(EBF1_disc1)


grid.newpage()
layout.rows <- 2
layout.cols <- 2
top.vp <- viewport(layout=grid.layout(layout.rows, layout.cols,
                                      widths=unit(rep(2,layout.cols), rep("null", layout.cols)),
                                      heights=unit(rep(2,1), rep("null",1))))

plot_reg <- vpList()
l <- 1
for(i in 1:layout.rows){
  for(j in 1:layout.cols){
    plot_reg[[l]] <- viewport(layout.pos.col = j, layout.pos.row = i, name = paste0("plotlogo", l))
    l <- l+1
  }
}


plot_tree <- vpTree(top.vp, plot_reg)

pushViewport(plot_tree)
seekViewport(paste0("plotlogo", 1))

nlogomaker(EBF1_disc1,logoheight = 'ic_log',color_profile = color_profile,
           frame_width = 1,
           newpage = FALSE,
           bg = bgmat,
           pop_name = 'epsilon = 0.01, ic log, p/q',
           control = list(gap_ylab=3.5, epsilon = 0.01))

seekViewport(paste0("plotlogo", 2))

nlogomaker(bgmat,logoheight = 'ic_log',color_profile = color_profile,
           frame_width = 1,pop_name = 'epsilon = 0.01, ic log, q/p',
           bg = (EBF1_disc1),
           newpage = FALSE,
           control = list(gap_ylab=3.5, epsilon = 0.01))

seekViewport(paste0("plotlogo", 3))

nlogomaker(EBF1_disc1,logoheight = 'log',color_profile = color_profile,
           frame_width = 1,pop_name = 'epsilon = 0.01, log, p/q',
           bg = bgmat,
           newpage = FALSE,
           control = list(gap_ylab=3.5, epsilon = 0.01))

seekViewport(paste0("plotlogo", 4))

nlogomaker(bgmat,logoheight = 'log',color_profile = color_profile,
           frame_width = 1,pop_name = 'epsilon = 0.01, log, q/p',
           bg = (EBF1_disc1),
           newpage = FALSE,
           control = list(gap_ylab=3.5, epsilon = 0.01))


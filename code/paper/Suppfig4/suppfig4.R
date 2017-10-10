########################
#EBF1 family
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
nlogomaker(EBF1_disc1,logoheight = 'ratio',color_profile = color_profile,
           frame_width = 1,pop_name = 'EBF1_disc1 (EDLogo)',
           control = list(gap_ylab=3.5))


######################
#neg logo plot for the other EBF1 family
#the logoheight is ratio
index=grep('EBF1',names(pfm))
#disc2
disc2=t(pfm[[249]]);rownames(disc2)=c('A','C','G','T');colnames(disc2)=1:ncol(disc2)
nlogomaker(disc2,logoheight = 'ratio',color_profile = color_profile,frame_width = 1,pop_name = 'EBF1_disc2',
           control = list(gap_ylab=3.5))
#known1
known1=t(pfm[[464]]);rownames(known1)=c('A','C','G','T');colnames(known1)=1:ncol(known1)
nlogomaker(known1,logoheight = 'ratio',color_profile = color_profile,frame_width = 1,pop_name = 'EBF1_known1',
           control = list(gap_ylab=3.5))
#known2
known2=t(pfm[[747]]);rownames(known2)=c('A','C','G','T');colnames(known2)=1:ncol(known2)
nlogomaker(known2,logoheight = 'ratio',color_profile = color_profile,frame_width = 1,pop_name = 'EBF1_known2',
           control = list(gap_ylab=3.5))
#knwon3
knwon3=t(pfm[[944]]);rownames(knwon3)=c('A','C','G','T');colnames(knwon3)=1:ncol(knwon3)
nlogomaker(knwon3,logoheight = 'ratio',color_profile = color_profile,frame_width = 1,pop_name = 'EBF1_known3',
           control = list(gap_ylab=3.5))
#known4
knwon4=t(pfm[[1325]]);rownames(knwon4)=c('A','C','G','T');colnames(knwon4)=1:ncol(knwon4)
nlogomaker(knwon4,logoheight = 'ratio',color_profile = color_profile,frame_width = 1,pop_name = 'EBF1_known4',
           control = list(gap_ylab=3.5))



###################   background + estimated PWM   ########################

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

bgmat <- matrix(0.25, dim(EBF1_disc1)[1], dim(EBF1_disc1)[2])
rownames(bgmat) <- rownames(EBF1_disc1)
colnames(bgmat) <- colnames(EBF1_disc1)

nlogomaker(bgmat,logoheight = 'ic_log',color_profile = color_profile,
           frame_width = 1,pop_name = 'EBF1_disc1 epsilon = 0.01, ic log',
           bg = (EBF1_disc1+0.01),
           control = list(gap_ylab=3.5, epsilon = 0.01))

nlogomaker(bgmat,logoheight = 'ic_log',color_profile = color_profile,
           frame_width = 1,pop_name = 'EBF1_disc1 epsilon = 0.01, ic log',
           bg = (EBF1_disc1+0.01),
           control = list(gap_ylab=3.5, epsilon = 0.01))


table <- bgmat
bg <- EBF1_disc1

total_chars = c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
                "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "zero", "one", "two",
                "three", "four", "five", "six", "seven", "eight", "nine", "dot", "comma",
                "dash", "colon", "semicolon", "leftarrow", "rightarrow")
frame_width=NULL
yscale_change=TRUE
pop_name = NULL
addlogos = NULL
addlogos_text = NULL
newpage = TRUE
yrange = NULL
xaxis=TRUE
yaxis=TRUE
xaxis_fontsize=10
xlab_fontsize=15
y_fontsize=15
main_fontsize=16
start=0.001
xlab = "X"
ylab = "Enrichment Score"
col_line_split="grey80"
control = list()

logoheight <- "log"

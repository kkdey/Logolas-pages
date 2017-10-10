##################################
#Figure 1, neg logo plots
library(Logolas)
color_profile = list("type" = "per_row",
                     "col" = RColorBrewer::brewer.pal(4,name ="Spectral"))
pwm=rbind(0.328,0.332,0.33,0.01)
rownames(pwm)=c('A','C','G','T')
colnames(pwm)=1:ncol(pwm)
logomaker(pwm,color_profile=color_profile,frame_width = 1,pop_name = '',control = list(gap_ylab=3.5))
nlogomaker(pwm,logoheight = 'ratio',color_profile = color_profile,pop_name = '',control = list(gap_ylab=3.5))
pwm=cbind(c(1,0,0,0),c(0.328,0.332,0.33,0.01),
          c(0.1,0.8,0.05,0.05),c(0,0.05,0.95,0))
rownames(pwm)=c('A','C','G','T')
colnames(pwm)=1:ncol(pwm)
logomaker(pwm,color_profile=color_profile,frame_width = 1,pop_name = '',control = list(gap_ylab=3.5))
nlogomaker(pwm,logoheight = 'ratio',color_profile = color_profile,pop_name = '',control = list(gap_ylab=3.5))





table <- pwm
logoheight = "ratio"
total_chars = c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
                "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "zero", "one", "two",
                "three", "four", "five", "six", "seven", "eight", "nine", "dot", "comma",
                "dash", "colon", "semicolon", "leftarrow", "rightarrow")
bg = NULL
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

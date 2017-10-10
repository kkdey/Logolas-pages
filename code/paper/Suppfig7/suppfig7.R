#####################
#setup
scale1=function(x){return(x/sum(x))}
getpwm=function(pfm,bg=NULL,type='dash'){
  if(is.null(bg)){bg=rep(1/nrow(pfm),nrow(pfm))}
  pfm=as.matrix(pfm)
  if(type=='pse'){
    pseudo=sqrt(dim(pfm)[2])*bg
    pwm=apply((pfm+pseudo),2,scale1)
  }else if(type=='prop'){
    pwm=apply(pfm,2,scale1)
  }else if(type=='dash'){
    pwm=(dash((pfm),optmethod = 'mixEM',mode = bg)$posmean)
  }else{pwm=NULL}
  if(nrow(pwm)==4){rownames(pwm)=c('A','C','G','T')}
  if(nrow(pwm)==20){rownames(pwm)=c('A' ,'R','N','D',   'C' ,  'Q',   'E' ,  'G',   'H' ,  'I',   'L' , 'K'  , 'M' ,  'F',   'P' ,  'S'  , 'T' ,  'W',   'Y',   'V')}
  colnames(pwm)=1:dim(pfm)[2]
  return(pwm)
}

#data
library(Logolas)
#m=cbind(c(14,6,8,3),c(2,3,0,26),c(24,1,3,3),c(27,2,0,2),c(0,3,0,28),c(1,7,4,19),c(15,0,16,0),c(11,8,11,1),c(24,0,4,3),c(3,0,1,27),c(2,1,1,27),c(25,2,2,2))
library(atSNP)
pfm=LoadMotifLibrary('http://compbio.mit.edu/encode-motifs/motifs.txt',tag = ">",
                     transpose = F, field = 1, sep = c("\t", " ", ">"), skipcols = 1, skiprows = 1,
                     pseudocount = 0)
color_profile = list("type" = "per_row",
                     "col" = RColorBrewer::brewer.pal(4,name ="Spectral"))
EBF1_disc1=t(pfm[[52]]);rownames(EBF1_disc1)=c('A','C','G','T');colnames(EBF1_disc1)=1:ncol(EBF1_disc1)
m=EBF1_disc1
color_profile = list("type" = "per_row",
                     "col" = RColorBrewer::brewer.pal(4,name ="Spectral"))

#plots
nlogomaker(getpwm(m,type='prop'),logoheight = 'log',color_profile = color_profile,frame_width = 1,
           control = list(gap_xlab=3),pop_name = 'log')
nlogomaker(getpwm(m,type='prop'),logoheight = 'log_odds',
           color_profile = color_profile,frame_width = 1,
           control = list(gap_xlab=3),pop_name = 'log odds')
nlogomaker(getpwm(m,type='prop'),logoheight = 'ratio',
           color_profile = color_profile,frame_width = 1,
           control = list(gap_xlab=3),pop_name = 'ratio')
nlogomaker(getpwm(m,type='prop'),logoheight = 'ic_log',
           color_profile = color_profile,frame_width = 1,
           control = list(gap_xlab=3),pop_name = 'ic log')
nlogomaker(getpwm(m,type='prop'),logoheight = 'ic_log_odds',
           color_profile = color_profile,frame_width = 1,
           control = list(gap_xlab=3),pop_name = 'ic log odds')
nlogomaker(getpwm(m,type='prop'),logoheight = 'ic_ratio',
           color_profile = color_profile,frame_width = 1,
           control = list(gap_xlab=3),pop_name = 'ic ratio')



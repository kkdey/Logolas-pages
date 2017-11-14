
##################  Fig  1 plot   #####################

###########  Panels (a)  - left and right   ######################

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

nlogomaker(EBF1_disc1,logoheight = 'log',color_profile = color_profile,
           frame_width = 1,pop_name = 'EBF1_disc1 epsilon = 0.01, log',
           bg = bgmat,
           control = list(gap_ylab=3.5, epsilon = 0.01))

nlogomaker(bgmat,logoheight = 'log',color_profile = color_profile,
           frame_width = 1,pop_name = 'EBF1_disc1 epsilon = 0.01, log',
           bg = EBF1_disc1,
           control = list(gap_ylab=3.5, epsilon = 0.01))


###########  Panels (b)  - left and right   ######################


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

#read data
library(Logolas)
readprotein=function(file,skip=3,nrows,nsites,bg=bg,adash,mat){
  library(dash)
  rawdata=read.table(file = file,skip = skip,nrows = nrows)
  if(mat=='pfm'){
    pwm=as.matrix(rawdata[,23:42]/100)
    pfm=round(pwm*nsites)
    colnames(pfm)=c('A' ,'R','N','D',   'C' ,  'Q',   'E' ,  'G',   'H' ,  'I',   'L' , 'K'  , 'M' ,  'F',   'P' ,  'S'  , 'T' ,  'W',   'Y',   'V')
    rownames(pfm)=1:nrow(pfm)
    return(t(pfm))
  }
  if(mat=='pwm'){
    pwm=as.matrix(rawdata[,23:42]/100)
    pfm=round(pwm*nsites)
    if(adash==T){
      pwm=dash(as.matrix(pfm),mode = bg,optmethod = 'mixEM')$posmean
    }
    colnames(pwm)=c('A' ,'R','N','D',   'C' ,  'Q',   'E' ,  'G',   'H' ,  'I',   'L' , 'K'  , 'M' ,  'F',   'P' ,  'S'  , 'T' ,  'W',   'Y',   'V')
    rownames(pwm)=1:nrow(pwm)
    return(t(pwm))
  }

  if(mat=='pssm'){
    pssm=as.matrix(rawdata[,3:22])
    colnames(pssm)=c('A' ,'R','N','D',   'C' ,  'Q',   'E' ,  'G',   'H' ,  'I',   'L' , 'K'  , 'M' ,  'F',   'P' ,  'S'  , 'T' ,  'W',   'Y',   'V')
    rownames(pssm)=1:nrow(pssm)
    return(t(pssm))
  }
  if(mat=='pssm_median'){
    pssm=as.matrix(rawdata[,3:22])
    pssm=apply(pssm,2,function(x){x-median(x)})
    colnames(pssm)=c('A' ,'R','N','D',   'C' ,  'Q',   'E' ,  'G',   'H' ,  'I',   'L' , 'K'  , 'M' ,  'F',   'P' ,  'S'  , 'T' ,  'W',   'Y',   'V')
    rownames(pssm)=1:nrow(pssm)
    return(t(pssm))
  }
}
pssm1= readprotein('http://caps.ncbs.res.in/cgi-bin/mini/databases/3pfdb/3pfdb_pssm_download.cgi?id=PF06445&data_dir=SDB_folder',nrows = 161,nsites = 100,adash = FALSE,mat='pfm')

pwm=pssm1[,153:160]
colnames(pwm)=1:ncol(pwm)

cols1 <- c(rev(RColorBrewer::brewer.pal(12, "Paired"))[c(3,4,7,8,11,12,5,6,9,10)],
           RColorBrewer::brewer.pal(12, "Set3")[c(1,2,5,8,9)],
           RColorBrewer::brewer.pal(9, "Set1")[c(9,7)],
           RColorBrewer::brewer.pal(8, "Dark2")[c(3,4,8)])
color_profile <- list("type" = "per_row",
                      "col" = cols1)

##########################
#plots

nlogomaker(getpwm(pwm,type = 'prop'),color_profile = color_profile,
           logoheight = 'log',control = list(epsilon=0.25,gap_xlab=3),
           pop_name = 'Protein (EDLogo)')



#############
#set up
library(Logolas)

readprotein=function(file,skip=3,nrows,nsites,bg=bg,adash,mat){
  library(Logolas)
  rawdata=read.table(file = file,skip = skip,nrows = nrows)
  if(mat=='pfm'){
    pwm=as.matrix(rawdata[,23:42]/100)
    pfm=round(pwm*nsites)
    colnames(pfm)=c('A' ,'R','N','D',   'C' ,  'Q',   'E' ,  'G',   'H' ,  'I',   'L' , 'K'  , 'M' ,  'F',   'P' ,  'S'  , 'T' ,  'W',   'Y',   'V')
    rownames(pfm)=1:nrow(pfm)
    return(t(pfm))
  }
  if(mat=='pwm'){
    pwm=as.matrix(rawdata[,23:42]/100)
    pfm=round(pwm*nsites)
    if(adash==T){
      pwm=t((dash(t(as.matrix(pfm)),mode = bg,optmethod = 'mixEM')$posmean))
    }
    colnames(pwm)=c('A' ,'R','N','D',   'C' ,  'Q',   'E' ,  'G',   'H' ,  'I',   'L' , 'K'  , 'M' ,  'F',   'P' ,  'S'  , 'T' ,  'W',   'Y',   'V')
    rownames(pwm)=1:nrow(pwm)
    return(t(pwm))
  }

  if(mat=='pssm'){
    pssm=as.matrix(rawdata[,3:22])
    colnames(pssm)=c('A' ,'R','N','D',   'C' ,  'Q',   'E' ,  'G',   'H' ,  'I',   'L' , 'K'  , 'M' ,  'F',   'P' ,  'S'  , 'T' ,  'W',   'Y',   'V')
    rownames(pssm)=1:nrow(pssm)
    return(t(pssm))
  }
  if(mat=='pssm_median'){
    pssm=as.matrix(rawdata[,3:22])
    pssm=apply(pssm,2,function(x){x-median(x)})
    colnames(pssm)=c('A' ,'R','N','D',   'C' ,  'Q',   'E' ,  'G',   'H' ,  'I',   'L' , 'K'  , 'M' ,  'F',   'P' ,  'S'  , 'T' ,  'W',   'Y',   'V')
    rownames(pssm)=1:nrow(pssm)
    return(t(pssm))
  }
}
pssm1= readprotein('http://caps.ncbs.res.in/cgi-bin/mini/databases/3pfdb/3pfdb_pssm_download.cgi?id=PF06445&data_dir=SDB_folder',nrows = 161,nsites = 100,adash = FALSE,mat='pssm')

pssm=pssm1[,153:160]
colnames(pssm)=1:ncol(pssm)


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
    pwm=t(dash(t(pfm),optmethod = 'mixEM',mode = bg,weight = list("center" = 1, "null" = 1, "corner" = 1))$posmean)
  }else{pwm=NULL}
  if(nrow(pwm)==4){rownames(pwm)=c('A','C','G','T')}
  if(nrow(pwm)==20){rownames(pwm)=c('A' ,'R','N','D',   'C' ,  'Q',   'E' ,  'G',   'H' ,  'I',   'L' , 'K'  , 'M' ,  'F',   'P' ,  'S'  , 'T' ,  'W',   'Y',   'V')}
  colnames(pwm)=1:dim(pfm)[2]
  return(pwm)
}
cols1 <- c(rev(RColorBrewer::brewer.pal(12, "Paired"))[c(3,4,7,8,11,12,5,6,9,10)],
           RColorBrewer::brewer.pal(12, "Set3")[c(1,2,5,8,9)],
           RColorBrewer::brewer.pal(9, "Set1")[c(9,7)],
           RColorBrewer::brewer.pal(8, "Dark2")[c(3,4,8)])
color_profile <- list("type" = "per_row",
                      "col" = cols1)
logo_pssm(pssm/max(pssm),color_profile = color_profile,
          control = list(gap_ylab=3.5), pop_name = "Protein (PSSM)")


###########  Panels (c)  - left and right   ######################


library(Logolas)
cols = RColorBrewer::brewer.pal.info[RColorBrewer::brewer.pal.info$category ==
                                       'qual',]
col_vector = unlist(mapply(RColorBrewer::brewer.pal, cols$maxcolors, rownames(cols)))
total_chars = c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
                "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "zero", "one", "two",
                "three", "four", "five", "six", "seven", "eight", "nine", "dot", "comma",
                "dash", "colon", "semicolon", "leftarrow", "rightarrow")

set.seed(20)
color_profile <- list("type" = "per_symbol",
                      "col" = sample(col_vector, length(total_chars), replace=FALSE))

load("../data/Lymphoma-B-cell.4.RData")
mat=resultForSave[[1]]@signatureFeatureDistribution[2,,]
mat1=cbind(t(mat[2:3,1:4]),rep(NA,4),t(mat[4:5,1:4]))
rownames(mat1)=c('A','C','G','T')
colnames(mat1) = c("-2", "-1", "0", "1", "2")
mat2=cbind(rep(NA,6),rep(NA,6),(mat[1,]),rep(NA,6),rep(NA,6))
colnames(mat2) = c("-2", "-1", "0", "1", "2")
rownames(mat2) = c("C>A", "C>G", "C>T", "T>A", "T>C", "T>G")
table = rbind(mat1, mat2)

logomaker(table,
          color_profile = color_profile,
          frame_width = 1,
          xlab = "Position",
          pop_name='B cell mutations (Logo)')
nlogomaker(table,
           logoheight = 'log',
           color_profile = color_profile,
           frame_width = 1,
           xlab = "Position",
           pop_name = 'B cell mutations (EDLogo)',
           control = list(epsilon=0.25,gap_ylab=3.5)
)

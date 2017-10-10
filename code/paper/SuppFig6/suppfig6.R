########################
#6 types of logo plots

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
           pop_name = 'log')
nlogomaker(getpwm(pwm,type = 'prop'),color_profile = color_profile,
           logoheight = 'log_odds',
           control = list(epsilon=0.25,gap_xlab=3),
           pop_name = 'log odds')
nlogomaker(getpwm(pwm,type = 'prop'),color_profile = color_profile,
           logoheight = 'ratio',control = list(epsilon=0.25,gap_xlab=3),
           pop_name = 'ratio')
nlogomaker(getpwm(pwm,type = 'prop'),color_profile = color_profile,
           logoheight = 'ic_log',control = list(epsilon=0.25,gap_xlab=3),
           pop_name = 'ic log')
nlogomaker(getpwm(pwm,type = 'prop'),color_profile = color_profile,
           logoheight = 'ic_log_odds',
           control = list(epsilon=0.25,gap_xlab=3),
           pop_name = 'ic log odds')
nlogomaker(getpwm(pwm,type = 'prop'),color_profile = color_profile,
           logoheight = 'ic_ratio',control = list(epsilon=0.25,gap_xlab=3),
           pop_name = 'ic ratio')



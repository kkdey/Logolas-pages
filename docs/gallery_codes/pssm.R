library(Logolas)

bg=c(0.074,0.052,0.045,0.054,0.025,0.034,0.054,0.074,0.026,0.068,0.099,0.058,0.025,0.047,0.039,0.057,0.051,0.013,0.034,0.073)
#A function to read the data
readprotein=function(file,skip=3,nrows,nsites,bg=bg,adash,mat){
  library(dash)
  rawdata=read.table(file = file,skip = skip,nrows = nrows)
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
}
#read data from 3FDB
pssm= readprotein('http://caps.ncbs.res.in/cgi-bin/mini/databases/3pfdb/3pfdb_pssm_download.cgi?id=PF07966&data_dir=SDB_folder',nrows = 29,nsites = 85,adash = FALSE,mat='pssm')
pssm=pssm[,19:27]
colnames(pssm)=1:9

cols1 <- c(rev(RColorBrewer::brewer.pal(12, "Paired"))[c(3,4,7,8,11,12,5,6,9,10)],
           RColorBrewer::brewer.pal(12, "Set3")[c(1,2,5,8,9)],
           RColorBrewer::brewer.pal(9, "Set1")[c(9,7)],
           RColorBrewer::brewer.pal(8, "Dark2")[c(3,4,8)])
color_profile <- list("type" = "per_row",
                      "col" = cols1)

logo_pssm(pssm,
          color_profile = color_profile,
          frame_width = 1,
          pop_name = "PSSM Logo plot: amino acids",
          control = list(viewport.margin.left = 6, gap_ylab = 4)
)

#########################
#dash example
#setup
library(Logolas)
library(grid)
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
    pwm=dash(pfm, optmethod = 'mixEM')$posmean
  }else{pwm=NULL}
  if(nrow(pwm)==4){rownames(pwm)=c('A','C','G','T')}
  if(nrow(pwm)==20){rownames(pwm)=c('A' ,'R','N','D',   'C' ,  'Q',   'E' ,  'G',   'H' ,  'I',   'L' , 'K'  , 'M' ,  'F',   'P' ,  'S'  , 'T' ,  'W',   'Y',   'V')}
  colnames(pwm)=1:dim(pfm)[2]
  return(pwm)
}
#sampling function
dashsample=function(pfm,n){
  p=apply(pfm,2,function(x){
    sam=sample(rep(c('A','C','G','T'),x),n,replace = F)
    n_a=sum(sam=='A')
    n_g=sum(sam=='G')
    n_c=sum(sam=='C')
    n_t=sum(sam=='T')
    return(c(n_a,n_c,n_g,n_t))
  })
  rownames(p)=c('A','C','G','T')
  return(p)
}
#pfm matrix
pfm=cbind(c(41,18,56,39),c(11,12,35,96),c(22,44,21,67),c(3,1,146,4),c(1,150,1,2),c(3,1,149,1),c(0,3,1,150),c(0,0,154,0),c(43,67,16,28))
rownames(pfm)=c('A','C','G','T')
colnames(pfm)=1:ncol(pfm)
logomaker(pfm,color_profile = color_profile,frame_width = 1,pop_name = 'true pwm')

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
set.seed(35)
pfms=dashsample(pfm,5)
color_profile <- list("type" = "per_row",
                      "col" = RColorBrewer::brewer.pal(dim(pfm)[1],name ="Spectral"))

logomaker(pfms,color_profile = color_profile,newpage = F,pop_name = 'Sample proportion,counts=5', y_fontsize = 10, main_fontsize=12)
seekViewport(paste0("plotlogo", 2))
logomaker(getpwm(pfms,type = 'dash'),color_profile = color_profile,newpage = F,pop_name = 'dash,counts=5', y_fontsize = 10, main_fontsize=12)
seekViewport(paste0("plotlogo", 3))
pfms=dashsample(pfm,30)
logomaker(pfms,color_profile = color_profile,newpage = F,pop_name = 'Sample proportion,counts=30', y_fontsize = 10, main_fontsize=12)
seekViewport(paste0("plotlogo", 4))
logomaker(getpwm(pfms,type = 'dash'),color_profile = color_profile,newpage = F,pop_name = 'dash,counts=30', y_fontsize = 10, main_fontsize=12)

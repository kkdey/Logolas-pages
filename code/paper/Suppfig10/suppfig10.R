########################
#Combined dash
#######################
#set up

#path: path to the data folder
#cb:whether combine all pfms or not. 'T' or 'F'
#bgs:'uniform' or 'specific'
plantTF=function(path,cb=T,bgs='specific'){
  library(dash)
  #read all the TF names from the infomation page
  nam=list.files(path)

  #record the original pwm from the website as a list
  pwm_original=list()
  #record the transformed pfm as a list
  pfm_indi=list()
  #record the pwm after applying the dash
  pwm_dash=list()
  #a large mattrix combine all the pfms
  pfm_cb=c()
  #record the number of positions for each pwm
  npos=c()
  #record the number of sequences of each pfm
  site=c()

  for(i in 1:length(nam)){
    #read each pwm file from the website
    readfile=readLines(paste(path,'/',nam[i],sep = ''))
    #extract the pwm
    pwm=matrix(as.numeric(as.character(unlist(strsplit(readfile[13:(length(readfile)-3)],split = '\t')))),nrow = 4,byrow = F)
    rownames(pwm)=c('A','C','G','T')
    colnames(pwm)=1:ncol(pwm)
    pwm_original[[i]]=pwm
    #extract the number of sites
    nsites=as.numeric(as.character(unlist(strsplit(readfile[12],split = ' '))[grep('nsites',unlist(strsplit(readfile[12],split = ' ')))+1]))
    site[i]=nsites
    #extract the background probabilities
    if(bgs=='specific'){
      bg=as.numeric(strsplit(readfile[8],split = ' ')[[1]][c(2,4,6,8)])
    }else if(bgs=='uniform'){bg=rep(0.25,4)}

    #
    pfm=round(pwm*nsites)
    if(cb==T){
      pfm_cb=cbind(pfm_cb,pfm)
    }
    npos[i]=ncol(pwm)
    pfm_indi[[i]]=pfm
    pwm=dash((pfm),optmethod = 'mixEM',mode = bg)
    pwm=(pwm$posmean)
    rownames(pwm)=c('A','C','G','T')
    colnames(pwm)=1:ncol(pwm)
    pwm_dash[[i]]=pwm
  }

  if(cb==T){
    pwm_cbdash=dash((pfm_cb),mode=bg,optmethod = 'mixEM')
    pwm_cbdash=(pwm_cbdash$posmean)
    pwm_cb=list()
    for(i in 1:length(npos)){
      pwm=pwm_cbdash[,1:npos[i]]
      rownames(pwm)=c('A','C','G','T')
      colnames(pwm)=1:ncol(pwm)
      pwm_cbdash=pwm_cbdash[,-(1:npos[i])]
      pwm_cb[[i]]=pwm
    }
  }else{pwm_cb=NULL}

  results=list(pfm=pfm_indi,pwm_original=pwm_original,pwm_dash=pwm_dash,pwm_cbdash=pwm_cb,bg=bg,nseq=site,npos=npos)

  return(results)
}
library(Logolas)
color_profile = list("type" = "per_row",
                     "col" = RColorBrewer::brewer.pal(4,name ="Spectral"))
##########################
#plots

Ach=plantTF("Ach")


##########################
#not combined, without bg, no dash
logomaker(Ach$pwm_original[[151]],xlab = 'position',color_profile = color_profile,
          frame_width = 1,
          bg=NULL,
          pop_name = 'uniform bg + no dash',
          yscale_change = F,
          control = list(viewport.margin.left = 5))
nlogomaker(Ach$pwm_original[[151]],xlab = 'position',color_profile = color_profile,
           logoheight = 'log',
           frame_width = 1,
           bg=NULL,
           pop_name = 'uniform bg + no dash',
           control = list(viewport.margin.left = 5))

#not combined, with bg, no dash
logomaker(Ach$pwm_original[[151]],xlab = 'position',color_profile = color_profile,
          frame_width = 1,
          bg=Ach$bg,
          pop_name = 'species bg + no dash',
          yscale_change = F,
          control = list(viewport.margin.left = 5))
nlogomaker(Ach$pwm_original[[151]],xlab = 'position',color_profile = color_profile,
           logoheight = 'log',
           frame_width = 1,
           bg=Ach$bg,
           pop_name = 'species bg + no dash',
           control = list(viewport.margin.left = 5))

#not combined, without bg, dash
pfm=Ach$pfm[[151]]
pwm=dash(pfm,optmethod = 'mixEM')$posmean
logomaker(pwm,xlab = 'position',color_profile = color_profile,
          frame_width = 1,
          bg=NULL,
          pop_name = 'uniform bg + dash',
          yscale_change = F,
          control = list(viewport.margin.left = 5))
nlogomaker(pwm,xlab = 'position',color_profile = color_profile,
           logoheight = 'log',
           frame_width = 1,
           bg=NULL,
           pop_name = 'uniform bg + dash',
           control = list(viewport.margin.left = 5))

#not combined, with bg, dash
logomaker(Ach$pwm_dash[[151]],xlab = 'position',color_profile = color_profile,
          frame_width = 1,
          bg=Ach$bg,
          pop_name = 'species bg + dash',
          yscale_change = F,
          control = list(viewport.margin.left = 5))
nlogomaker(Ach$pwm_dash[[151]],xlab = 'position',color_profile = color_profile,
           frame_width = 1,
           logoheight = 'log',
           bg=Ach$bg,
           pop_name = 'species bg + dash',
           control = list(viewport.margin.left = 5))

#combined, with bg, dash
logomaker(Ach$pwm_cbdash[[151]],
          xlab = 'position',color_profile = color_profile,
          frame_width = 1,
          bg=Ach$bg,
          yscale_change = F,
          pop_name = 'species bg + combo dash',
          control = list(viewport.margin.left = 5))
nlogomaker(Ach$pwm_cbdash[[151]],
           xlab = 'position',color_profile = color_profile,
           logoheight = 'log',
           frame_width = 1,
           bg=Ach$bg,
           pop_name = 'species bg + combo dash',
           control = list(viewport.margin.left = 5))

#combined, without bg, dash
Ach1=plantTF("Ach",bgs='uniform')
logomaker(Ach1$pwm_cbdash[[151]],
          xlab = 'position',color_profile = color_profile,
          frame_width = 1,
          bg=NULL,
          yscale_change = F,
          pop_name = 'uniform bg + combo dash',
          control = list(viewport.margin.left = 5))
nlogomaker(Ach1$pwm_cbdash[[151]],
           xlab = 'position',color_profile = color_profile,
           logoheight = 'log',
           frame_width = 1,
           bg=NULL,
           pop_name = 'uniform bg + combo dash',
           control = list(viewport.margin.left = 5))





grid.newpage()
layout.rows <- 2
layout.cols <- 2
top.vp <- viewport(layout=grid.layout(layout.rows, layout.cols,
                                      widths=unit(rep(5,layout.cols), rep("null", 2)),
                                      heights=unit(rep(5,layout.rows), rep("null", 1))))
plot_reg <- vpList()
l <- 1
for(i in 1:layout.rows){
  for(j in 1:layout.cols){
    plot_reg[[l]] <- viewport(layout.pos.col = j, layout.pos.row = i, name = paste0("plotlogo", l))
    l <- l+1
  }
}


grid.newpage()
plot_tree <- vpTree(top.vp, plot_reg)

pushViewport(plot_tree)

##########################
#not combined, without bg, no dash

# seekViewport(paste0("plotlogo", 1))
# logomaker(Ach$pwm_original[[151]],xlab = 'position',color_profile = color_profile,
#           frame_width = 1,
#           bg=NULL,
#           newpage = FALSE,
#           pop_name = 'uniform bg + no dash',
#           yscale_change = F,
#           control = list(viewport.margin.left = 5))
#
# seekViewport("plotlogo2")
# nlogomaker(Ach$pwm_original[[151]],xlab = 'position',color_profile = color_profile,
#            logoheight = 'log',
#            frame_width = 1,
#            bg=NULL,
#            pop_name = 'uniform bg + no dash',
#            newpage = FALSE,
#            control = list(viewport.margin.left = 5))

# #not combined, with bg, no dash
#
# seekViewport("plotlogo3")
# logomaker(Ach$pwm_original[[151]],xlab = 'position',color_profile = color_profile,
#           frame_width = 1,
#           bg=Ach$bg,
#           pop_name = 'species bg + no dash',
#           yscale_change = F,
#           newpage = FALSE,
#           control = list(viewport.margin.left = 5))
#
# seekViewport("plotlogo4")
# nlogomaker(Ach$pwm_original[[151]],xlab = 'position',color_profile = color_profile,
#            logoheight = 'log',
#            frame_width = 1,
#            bg=Ach$bg,
#            pop_name = 'species bg + no dash',
#            newpage = FALSE,
#            control = list(viewport.margin.left = 5))
#
# #not combined, without bg, dash
# pfm=Ach$pfm[[151]]
# pwm=dash(pfm,optmethod = 'mixEM')$posmean
#
# seekViewport("plotlogo5")
# logomaker(pwm,xlab = 'position',color_profile = color_profile,
#           frame_width = 1,
#           bg=NULL,
#           pop_name = 'uniform bg + dash',
#           yscale_change = F,
#           newpage = FALSE,
#           control = list(viewport.margin.left = 5))
#
# seekViewport("plotlogo6")
# nlogomaker(pwm,xlab = 'position',color_profile = color_profile,
#            logoheight = 'log',
#            frame_width = 1,
#            bg=NULL,
#            pop_name = 'uniform bg + dash',
#            newpage = FALSE,
#            control = list(viewport.margin.left = 5))

#not combined, with bg, dash

seekViewport("plotlogo1")
logomaker(Ach$pwm_dash[[151]],xlab = 'position',color_profile = color_profile,
          frame_width = 1,
          bg=Ach$bg,
          pop_name = 'species bg + dash',
          yscale_change = F,
          newpage = FALSE,
          control = list(viewport.margin.left = 5))

seekViewport("plotlogo2")
nlogomaker(Ach$pwm_dash[[151]],xlab = 'position',color_profile = color_profile,
           frame_width = 1,
           logoheight = 'log',
           bg=Ach$bg,
           pop_name = 'species bg + dash',
           newpage = FALSE,
           control = list(viewport.margin.left = 5))

#combined, with bg, dash

seekViewport("plotlogo3")
logomaker(Ach$pwm_cbdash[[151]],
          xlab = 'position',color_profile = color_profile,
          frame_width = 1,
          bg=Ach$bg,
          yscale_change = F,
          pop_name = 'species bg + combo dash',
          newpage = FALSE,
          control = list(viewport.margin.left = 5))

seekViewport("plotlogo4")
nlogomaker(Ach$pwm_cbdash[[151]],
           xlab = 'position',color_profile = color_profile,
           logoheight = 'log',
           frame_width = 1,
           bg=Ach$bg,
           pop_name = 'species bg + combo dash',
           newpage = FALSE,
           control = list(viewport.margin.left = 5))

#combined, without bg, dash
# Ach1=plantTF("Ach",bgs='uniform')
#
# seekViewport("plotlogo11")
# logomaker(Ach1$pwm_cbdash[[151]],
#           xlab = 'position',color_profile = color_profile,
#           frame_width = 1,
#           bg=NULL,
#           yscale_change = F,
#           pop_name = 'uniform bg + combo dash',
#           newpage = FALSE,
#           control = list(viewport.margin.left = 5))
#
# seekViewport("plotlogo12")
# nlogomaker(Ach1$pwm_cbdash[[151]],
#            xlab = 'position',color_profile = color_profile,
#            logoheight = 'log',
#            frame_width = 1,
#            bg=NULL,
#            pop_name = 'uniform bg + combo dash',
#            newpage = FALSE,
#            control = list(viewport.margin.left = 5))
#



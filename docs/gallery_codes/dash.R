library(Logolas)
library(grid)

pfm1=cbind(c(1,2,1,1),c(0,0,5,0),c(0,3,1,1),c(0,5,0,0),c(0,3,0,2),c(0,0,5,0),c(2,1,2,0),c(0,0,5,0),c(1,1,0,3))
pfm2=cbind(c(1,9,5,5),c(1,16,2,1),c(1,1,18,0),c(1,0,2,17),c(18,1,0,1),c(1,18,0,0),c(1,2,16,1),c(6,4,7,3),c(2,12,1,5),c(8,5,5,2))
pfm3=cbind(c(31,8,46,29),c(1,2,25,86),c(12,34,11,57),c(3,1,106,4),c(1,110,1,2),c(3,1,109,1),c(0,3,1,110),c(0,0,114,0),c(33,57,6,18))
rownames(pfm1)=c('A','C','G','T')
colnames(pfm1)=1:ncol(pfm1)
rownames(pfm2)=c('A','C','G','T')
colnames(pfm2)=1:ncol(pfm2)
rownames(pfm3)=c('A','C','G','T')
colnames(pfm3)=1:ncol(pfm3)

color_profile = list("type" = "per_row", 
                     "col" = RColorBrewer::brewer.pal(4,name ="Spectral"))

grid.newpage()
layout.rows <- 2
layout.cols <- 3
top.vp <- viewport(layout=grid.layout(layout.rows,layout.cols, widths=unit(rep(2,layout.cols), rep("null",layout.cols)),heights=unit(rep(2,1), rep("null",1))))

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
logomaker(pfm1,
          color_profile = color_profile,
          frame_width = 1,
          newpage = F,
          yscale_change = F,
          pop_name = 'low freq')
seekViewport(paste0('plotlogo',2))
pfm1dash=t(dash(t(pfm1),optmethod = 'mixEM')$posmean)
rownames(pfm1dash)=c('A','C','G','T')
colnames(pfm1dash)=1:ncol(pfm1)
logomaker(pfm1dash,
          color_profile = color_profile,
          frame_width = 1,
          newpage=F,
          yscale_change = F,
          pop_name = 'low freq, dash')

seekViewport(paste0("plotlogo", 3))
logomaker(pfm2,
          color_profile = color_profile,
          frame_width = 1,
          newpage = F,
          yscale_change = F,
          pop_name = 'medium freq')
seekViewport(paste0('plotlogo',4))
pfm2dash=t(dash(t(pfm2),optmethod = 'mixEM')$posmean)
rownames(pfm2dash)=c('A','C','G','T')
colnames(pfm2dash)=1:ncol(pfm2)
logomaker(pfm2dash,
          color_profile = color_profile,
          frame_width = 1,
          newpage=F,
          yscale_change = F,
          pop_name = 'medium freq, dash')

seekViewport(paste0("plotlogo", 5))
logomaker(pfm3,
          color_profile = color_profile,
          frame_width = 1,
          newpage = F,
          yscale_change = F,
          pop_name = 'high freq')
seekViewport(paste0('plotlogo',6))
pfm3dash=t(dash(t(pfm3),optmethod = 'mixEM')$posmean)
rownames(pfm3dash)=c('A','C','G','T')
colnames(pfm3dash)=1:ncol(pfm3)
logomaker(pfm3dash,
          color_profile = color_profile,
          frame_width = 1,
          newpage=F,
          yscale_change = F,
          pop_name = 'high freq, dash')
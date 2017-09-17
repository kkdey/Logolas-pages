library(Logolas)
library(grid)

mFile <- system.file("Exfiles/pwm1", package="seqLogo")
m <- read.table(mFile)
p <- seqLogo::makePWM(m)
color_profile <- list("type" = "per_row",
                      "col" = RColorBrewer::brewer.pal(dim(p@pwm)[1],name ="Spectral"))

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


plot_tree <- vpTree(top.vp, plot_reg)

pushViewport(plot_tree)
#change the color of letters
#change the diverging palettes
color_profile1=list("type" = "per_row",
                    "col" = RColorBrewer::brewer.pal(dim(p@pwm)[1],name ="PiYG"))
seekViewport(paste0("plotlogo", 1))
logomaker(p@pwm,xlab = 'position',color_profile = color_profile1,
          frame_width = 1,
          newpage = FALSE,
          pop_name = 'Change color',
          control = list(viewport.margin.left = 5))

#change the y scale:
#if yscale_change = FALSE, then the height of y axis would be 2. 
seekViewport(paste0("plotlogo", 2))
logomaker(p@pwm,xlab = 'position',color_profile = color_profile,
          frame_width = 1,
          newpage = FALSE,
          pop_name = 'change y scale',
          yscale_change = FALSE,
          control = list(viewport.margin.left = 5))
#Normalize the height of bars to 1
seekViewport(paste0("plotlogo", 3))
logomaker(p@pwm,xlab = 'position',color_profile = color_profile,
          frame_width = 1,
          newpage = FALSE,
          ic.scale = FALSE,
          pop_name = 'Normalize the height',
          control = list(viewport.margin.left = 5))
#change the background probability
#And modify the title and the axis label 
seekViewport(paste0("plotlogo", 4))
logomaker(p@pwm,xlab = 'position',color_profile = color_profile,
          frame_width = 1,
          bg=c(0.32, 0.18, 0.2, 0.3),
          newpage = FALSE,
          pop_name = 'Change background prob',
          control = list(viewport.margin.left = 5))
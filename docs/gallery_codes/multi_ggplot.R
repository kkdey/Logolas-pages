library(ggplot2)
library(grid)

m = matrix(rep(0,48),4,12)
m[1,] = c(0,0,2.5,7,0,0,0,0,0,0,1,2)
m[2,] = c(4,6,3,1,0,0,0,0,0,5,0,2)
m[3,] = c(0,0,0,0,0,1,8,0,0,1,1,2)
m[4,] = c(4,2,2.5,0,8,7,0,8,8,2,6,2)
rownames(m) = c("A", "C", "G", "T")
colnames(m) = 1:12
m=m/8

color_profile = list("type" = "per_row",
                     "col" = RColorBrewer::brewer.pal(4,name ="Spectral"))

mtcars$gear <- factor(mtcars$gear,levels=c(3,4,5),
                      labels=c("3gears","4gears","5gears"))

grid.newpage()
layout.rows <- 1
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
logomaker(m,
           xlab = 'position',color_profile = color_profile,
          bg = c(0.28, 0.22, 0.24, 0.26),
          frame_width = 1,
          newpage = FALSE,
          control = list(gap_xlab=2.6))


seekViewport(paste0("plotlogo", 2))
vp3 = viewport(width=0.8, height=0.8, x = 0.5, y = 0.5)
p <- qplot(mpg, data=mtcars, geom="density")
print(p, vp = vp3)

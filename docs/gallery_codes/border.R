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

seekViewport(paste0("plotlogo", 1))
nlogomaker(p@pwm,xlab = 'position',logoheight = "log",
           color_profile = color_profile,
           bg = c(0.25, 0.25, 0.25, 0.25),
           frame_width = 1,
           control = list(tofill_pos = TRUE, tofill_neg=FALSE,
                          logscale = 0.2, quant = 0.5,
                          depletion_weight = 0.5),
           newpage = FALSE)

seekViewport(paste0("plotlogo", 2))
nlogomaker(p@pwm,xlab = 'position',logoheight = "log",
           color_profile = color_profile,
           bg = c(0.25, 0.25, 0.25, 0.25),
           frame_width = 1,
           control = list(tofill_pos = FALSE, tofill_neg=TRUE,
                          logscale = 0.2, quant = 0.5,
                          depletion_weight = 0.5),
           newpage = FALSE)

seekViewport(paste0("plotlogo", 3))
nlogomaker(p@pwm,xlab = 'position',logoheight = "log",
           color_profile = color_profile,
           bg = c(0.25, 0.25, 0.25, 0.25),
           frame_width = 1,
           control = list(tofill_pos = TRUE, tofill_neg=TRUE,
                          logscale = 0.2, quant = 0.5,
                          depletion_weight = 0.5),
           newpage = FALSE)

seekViewport(paste0("plotlogo", 4))
nlogomaker(p@pwm,xlab = 'position',logoheight = "log",
           color_profile = color_profile,
           bg = c(0.25, 0.25, 0.25, 0.25),
           frame_width = 1,
           control = list(tofill_pos = FALSE, tofill_neg=FALSE,
                          logscale = 0.2, quant = 0.5,
                          depletion_weight = 0.5),
           newpage = FALSE)
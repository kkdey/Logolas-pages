library(Logolas)
library(grid)

data(seqlogo_example)
get_viewport_logo(2, 2, heights_1 = 16)

seekViewport(paste0("plotlogo", 1))
logomaker(seqlogo_example, type = "Logo", color_type = "per_row", colors = RColorBrewer::brewer.pal(dim(seqlogo_example)[1],name ="PiYG"),
          logo_control = list(newpage = FALSE))

seekViewport(paste0("plotlogo", 2))
logomaker(seqlogo_example, type = "Logo", logo_control = list(yscale_change = FALSE, newpage = FALSE))

seekViewport(paste0("plotlogo", 3))
logomaker(seqlogo_example, type = "Logo", logo_control = list(ic.scale = FALSE, newpage = FALSE))

bg=c(0.32, 0.18, 0.2, 0.3)
names(bg) <- c("A", "C", "G", "T")
seekViewport(paste0("plotlogo", 4))
logomaker(seqlogo_example, type = "Logo", bg = bg, logo_control = list(newpage = FALSE))

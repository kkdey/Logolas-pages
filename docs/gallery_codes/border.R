library(Logolas)
library(grid)

data("seqlogo_example")
get_viewport_logo(2, 2, heights_1 = 16)

seekViewport(paste0("plotlogo", 1))
logomaker(seqlogo_example, type = "EDLogo", color_type = "per_row", colors = c("#ABDDA4","#FDAE61", "#2B83BA", "#D7191C"),
          logo_control = list(newpage = FALSE, control = list(tofill_pos = TRUE, tofill_neg=TRUE)))


seekViewport(paste0("plotlogo", 2))
logomaker(seqlogo_example, type = "EDLogo", color_type = "per_row", colors = c("#ABDDA4","#FDAE61", "#2B83BA", "#D7191C"),
          logo_control = list(newpage = FALSE, control = list(tofill_pos = TRUE, tofill_neg=FALSE)))


seekViewport(paste0("plotlogo", 3))
logomaker(seqlogo_example, type = "EDLogo", color_type = "per_row", colors = c("#ABDDA4","#FDAE61", "#2B83BA", "#D7191C"),
          logo_control = list(newpage = FALSE, control = list(tofill_pos = FALSE, tofill_neg=TRUE)))


seekViewport(paste0("plotlogo", 4))
logomaker(seqlogo_example, type = "EDLogo", color_type = "per_row", colors = c("#ABDDA4","#FDAE61", "#2B83BA", "#D7191C"),
          logo_control = list(newpage = FALSE, control = list(tofill_pos = FALSE, tofill_neg=FALSE)))

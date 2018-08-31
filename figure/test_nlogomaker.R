
##############    test nlogomaker    ################

library(Logolas)
mut <- get(load(system.file("extdata", "mutation_signatures.rda", package = "Logolas")))

cols = RColorBrewer::brewer.pal.info[RColorBrewer::brewer.pal.info$category == 'qual',]
col_vector = unlist(mapply(RColorBrewer::brewer.pal, cols$maxcolors, rownames(cols)))
total_chars = c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
                "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "zero", "one", "two",
                "three", "four", "five", "six", "seven", "eight", "nine", "dot", "comma",
                "dash", "colon", "semicolon", "leftarrow", "rightarrow")

set.seed(20)
col_vector[c(1,3,7, 20, 43)] <- c("red", "blue", "orange", "green", "gray")
color_profile <- list("type" = "per_symbol",
                      "col" = col_vector)

nlogomaker(table,
           color_profile = color_profile,
           yrange = 1.2,
           score = "log")

bg = NULL
frame_width=NULL
yscale_change=TRUE
pop_name = NULL
addlogos = NULL
addlogos_text = NULL
newpage = TRUE
yrange = NULL
xaxis=TRUE
yaxis=TRUE
xaxis_fontsize=10
xlab_fontsize=15
y_fontsize=15
main_fontsize=16
start=0.001
xlab = "X"
ylab = "Enrichment Score"
col_line_split="grey80"
control = list()

get_logo_heights(table, score = "log")

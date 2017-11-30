
#################   IC scaling EDLogos for the mutSig  #####################


set.seed(20)
cols = RColorBrewer::brewer.pal.info[RColorBrewer::brewer.pal.info$category ==
                                       'qual',]
col_vector = unlist(mapply(RColorBrewer::brewer.pal, cols$maxcolors, rownames(cols)))
total_chars = c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
                "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "zero", "one", "two",
                "three", "four", "five", "six", "seven", "eight", "nine", "dot", "comma",
                "dash", "colon", "semicolon", "leftarrow", "rightarrow")
color_profile <- list("type" = "per_symbol",
                      "col" = sample(col_vector, length(total_chars), replace=FALSE))
load('../../data/Lymphoma-B-cell.4.Rdata')

mat=resultForSave[[1]]@signatureFeatureDistribution[2,,]
mat1=cbind(t(mat[2:3,1:4]),rep(NA,4),t(mat[4:5,1:4]))
rownames(mat1)=c('A','C','G','T')
colnames(mat1) = c("-2", "-1", "0", "1", "2")
mat2=cbind(rep(NA,6),rep(NA,6),(mat[1,]),rep(NA,6),rep(NA,6))
colnames(mat2) = c("-2", "-1", "0", "1", "2")
rownames(mat2) = c("C>A", "C>G", "C>T", "T>A", "T>C", "T>G")
table = rbind(mat1, mat2)


nlogomaker(table[, 2:4],
           logoheight = 'log',
           color_profile = color_profile,
           frame_width = 1,
           xlab = "Position",
           pop_name = '',
           bg = bgtable[,2:4],
           control = list(epsilon=0.25,gap_ylab=3.5,
                          round_off = 1, symm = TRUE),
           xaxis = FALSE
)

get_logo_heights_log(table, bg = bgtable)





Logolas::get_logo_heights_ic_log(table, alpha = 1, hist = FALSE)


logoheight = 'ic_ratio'
color_profile = color_profile
frame_width = 1
xlab = "Position"
pop_name = ''
control = list(epsilon=0.25,gap_ylab=3.5,
               round_off = 0)
xaxis = FALSE
bg = NULL
yscale_change=TRUE
addlogos = NULL
addlogos_text = NULL
newpage = TRUE
yrange = NULL
yaxis=TRUE
xaxis_fontsize=10
xlab_fontsize=15
y_fontsize=15
main_fontsize=16
start=0.001
ylab = "Enrichment Score"
col_line_split="grey80"


mat <- table_mat_norm
bg <- bgmat1


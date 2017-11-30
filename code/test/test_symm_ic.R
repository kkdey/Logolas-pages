

#########  test symmetric version of the information content  ##############


m = matrix(rep(0,48),4,12)
m[1,] = c(0,0,2.5,7,0,0,0,0,0,0,1,0)
m[2,] = c(4,6,3,1,0,0,0,0,0,5,0,5)
m[3,] = c(0,0,0,0,0,1,8,0,0,1,1,2)
m[4,] = c(4,2,2.5,0,8,7,0,8,8,2,6,1)
rownames(m) = c("A", "C", "G", "T")
colnames(m) = 1:12
m=m/8
get_logo_heights_ic_log(m, alpha = 1, hist = FALSE, symm = FALSE)
get_logo_heights_ic_log(m, alpha = 1, hist = FALSE, symm = TRUE)


library(Logolas)
#read all the motif data from http://compbio.mit.edu/encode-motifs/motifs.txt
library(atSNP)
pfm=LoadMotifLibrary('http://compbio.mit.edu/encode-motifs/motifs.txt',tag = ">",
                     transpose = F, field = 1, sep = c("\t", " ", ">"), skipcols = 1, skiprows = 1,
                     pseudocount = 0)
color_profile = list("type" = "per_row",
                     "col" = RColorBrewer::brewer.pal(4,name ="Spectral"))
EBF1_disc1=t(pfm[[52]]);rownames(EBF1_disc1)=c('A','C','G','T');colnames(EBF1_disc1)=1:ncol(EBF1_disc1)
######################

bgmat <- matrix(0.25, dim(EBF1_disc1)[1], dim(EBF1_disc1)[2])
rownames(bgmat) <- rownames(EBF1_disc1)
colnames(bgmat) <- colnames(EBF1_disc1)

get_logo_heights_ic_log(EBF1_disc1, bg = bgmat, symm = TRUE)
get_logo_heights_ic_log(EBF1_disc1, bg = bgmat, symm = FALSE)


get_viewport_logo(3, 2)

seekViewport(paste0("plotlogo", 1))

nlogomaker(EBF1_disc1,logoheight = 'log',color_profile = color_profile,
           newpage = FALSE,
           bg = bgmat,
           pop_name = 'log (p/q)',
           control = list(gap_ylab=3.5, epsilon = 0.01))

seekViewport(paste0("plotlogo", 2))

nlogomaker(bgmat,logoheight = 'log',color_profile = color_profile,
           pop_name = 'log (q/p)',
           bg = (EBF1_disc1),
           newpage = FALSE,
           control = list(gap_ylab=3.5, epsilon = 0.01))


seekViewport(paste0("plotlogo", 3))

nlogomaker(EBF1_disc1,logoheight = 'ic_log',color_profile = color_profile,
           newpage = FALSE,
           bg = bgmat,
           pop_name = 'symm KL log (p /q)',
           control = list(gap_ylab=3.5, epsilon = 0.01, symm = TRUE))


seekViewport(paste0("plotlogo", 4))

nlogomaker(bgmat,logoheight = 'ic_log',color_profile = color_profile,
           pop_name = 'symm KL (q/p)',
           bg = (EBF1_disc1),
           newpage = FALSE,
           control = list(gap_ylab=3.5, epsilon = 0.01, symm = TRUE))


seekViewport(paste0("plotlogo", 5))

nlogomaker(EBF1_disc1,logoheight = 'ic_log',color_profile = color_profile,
           bg = bgmat,
           newpage = FALSE,
           pop_name = 'non symm KL log (p /q)',
           control = list(gap_ylab=3.5, epsilon = 0.01, symm = FALSE))


seekViewport(paste0("plotlogo", 6))

nlogomaker(bgmat,logoheight = 'ic_log',color_profile = color_profile,
           pop_name = 'non symm KL (q/p)',
           bg = (EBF1_disc1),
           newpage = FALSE,
           control = list(gap_ylab=3.5, epsilon = 0.01, symm = FALSE))







alpha = 1
epsilon = 0.01
bg = NULL
opt = 1
hist = FALSE
quant = 0.5
symm = TRUE

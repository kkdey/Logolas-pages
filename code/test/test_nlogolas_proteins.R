
#########  Test logolas on proteins ################


proteins_pwm <- get(load("../../data/protein_pwm.RData"))
m <- proteins_pwm$pwm05986

cols1 <- c(rev(RColorBrewer::brewer.pal(12, "Paired"))[c(3,4,7,8,11,12,5,6,9,10)],
           RColorBrewer::brewer.pal(12, "Set3")[c(1,2,5,8,9)],
           RColorBrewer::brewer.pal(9, "Set1")[c(9,7)],
           RColorBrewer::brewer.pal(8, "Dark2")[c(3,4,8)])

color_profile <- list("type" = "per_row",
                      "col" = cols1)

nlogomaker(m, logoheight = "probKL",
           color_profile = color_profile,
           frame_width = 1,
           control = list(quant = 0,
                          depletion_weight = 0, epsilon = 0.1))

Logolas::nlogomaker(m, logoheight = "wKL",
           color_profile = color_profile,
           frame_width = 1,
           control = list(quant = 0,
                          depletion_weight = 0, epsilon = 0.1))

Logolas::nlogomaker(m, logoheight = "wKL",
                    color_profile = color_profile,
                    frame_width = 1,
                    control = list(quant = 0.5,
                                   depletion_weight = 0, epsilon = 0.1))



mFile <- system.file("Exfiles/pwm1", package="seqLogo")
m <- read.table(mFile)
p <- seqLogo::makePWM(m)
pwm_mat <- slot(p,name = "pwm")
pwm_mat <- apply(pwm_mat+0.0001,2, function(x) { return(x/sum(x))})
mat1 <- cbind(pwm_mat[,c(3,4)], rep(0,4), pwm_mat[,c(5,6)]);

colnames(mat1) <- c("-2", "-1", "0", "1", "2")
mat2 <- cbind(rep(0,6), rep(0,6),
              c(0.9, 0.01, 0.01, 0.02, 0.03, 0.03),
              rep(0,6), rep(0,6))
rownames(mat2) <- c("C>T", "C>A", "C>G",
                    "T>A", "T>C", "T>G")

table <- rbind(mat1, mat2)

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


table[table == 0] <- NA

Logolas::nlogomaker(table, logoheight = "wKL",
                    color_profile = color_profile,
                    frame_width = 1,
                    control = list(quant = 0.5,
                                   depletion_weight = 0, epsilon = 0.1))


Logolas::nlogomaker(table, logoheight = "probKL",
                    color_profile = color_profile,
                    frame_width = 1,
                    control = list(quant = 0,
                                   depletion_weight = 0, epsilon = 0.1))



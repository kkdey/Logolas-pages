library(Logolas)

################  Get logo heights (difference approach) ###################

m = matrix(rep(0,48),4,12)
m[1,] = c(0,0,2.5,7,0,0,0,0,0,0,1,0)
m[2,] = c(4,6,3,1,0,0,0,0,0,5,0,5)
m[3,] = c(0,0,0,0,0,1,8,0,0,1,1,2)
m[4,] = c(4,2,2.5,0,8,7,0,8,8,2,6,1)
rownames(m) = c("A", "C", "G", "T")
colnames(m) = 1:12
m=m/8
get_logo_heights_diff(m)
get_logo_heights_ic_diff(m, alpha = 1)
get_logo_heights_ic_log(m, alpha = 1, hist = FALSE)
get_logo_heights_ratio(m)

##############  GetConsensusSeq code   ################


pwm=matrix(c(0.8,0.1,0.1,0,0.9,0.1,0,0,0.9,0.05,0.05,0,0.5,0.4,0,0.1,0.6,0.4,0,0,0.4,0.4,0.1,0.1,0.5,0,0.2,0.3,0.35,0.35,0.06,0.24,0.4,0.3,0.2,0.1,0.4,0.2,0.2,0.2,0.28,0.24,0.24,0.24,0.5,0.16,0.17,0.17,0.6,0.13,0.13,0.14,0.7,0.15,0.15,0),nrow = 4,byrow = F)
rownames(pwm)=c('A','C','G','T')
colnames(pwm)=1:ncol(pwm)
GetConsensusSeq(pwm)

###############   neg_ic_computer  ##################

m = matrix(rep(0,48),4,12)
m[1,] = c(0,0,2.5,7,0,0,0,0,0,0,1,0)
m[2,] = c(4,6,3,1,0,0,0,0,0,5,0,5)
m[3,] = c(0,0,0,0,0,1,8,0,0,1,1,2)
m[4,] = c(4,2,2.5,0,8,7,0,8,8,2,6,1)
rownames(m) = c("A", "C", "G", "T")
colnames(m) = 1:12
m=m/8
ic2 <- neg_ic_computer(m)
ic2$ic_pos
ic2$ic_neg
ic2$scales

##############  PSSM plot  ####################

m = matrix(rep(0,28),4,7)
m[1,] = c(-10,-6, -5, 4, -10, 4, 5)
m[2,] = c(-2,4, -6, 3, -3, 3, 0)
m[3,] = c(1,-5, -2, -1, 20, -3, -12)
m[4,] = c(10,1, 20, 0, 0, -4, 8)
rownames(m) = c("A", "C", "G", "T")
colnames(m) = 1:7



color_profile = list("type" = "per_row",
                     "col" = RColorBrewer::brewer.pal(4,name ="Spectral"))


logo_pssm(m,xlab = 'position',
          color_profile = color_profile,
          frame_width = 1)


 mat <- cbind(c(5, 0, 2, 0),
              c(1, 1, 0, 1),
              c(100, 100, 50, 100),
              c(20, 50, 100, 10),
              c(10, 10, 200, 20),
              c(50, 54, 58, 53),
              c(1,1,1,3),
              c(2, 4, 1, 1))
 out <- dash(mat, optmethod = "mixEM", verbose=TRUE)
 out <- dash(mat, optmethod = "w_mixEM", verbose=TRUE)


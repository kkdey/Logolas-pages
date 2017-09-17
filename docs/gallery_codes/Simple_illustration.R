library(Logolas)

mFile <- system.file("Exfiles/pwm1", package="seqLogo")
m <- read.table(mFile)
p <- seqLogo::makePWM(m)
color_profile <- list("type" = "per_row",
                      "col" = RColorBrewer::brewer.pal(dim(p@pwm)[1],name ="Spectral"))

logomaker(p@pwm,color_profile = color_profile, frame_width = 1,ic.scale = TRUE)
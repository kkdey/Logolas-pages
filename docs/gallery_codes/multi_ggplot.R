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

mtcars$gear <- factor(mtcars$gear,levels=c(3,4,5),
                      labels=c("3gears","4gears","5gears"))

get_viewport_logo(1, 2, heights_1 = 16)

seekViewport(paste0("plotlogo", 1))
logomaker(m, type ="EDLogo", colors = c("#ABDDA4","#FDAE61", "#2B83BA", "#D7191C"),
          logo_control = list(newpage = FALSE))

seekViewport(paste0("plotlogo", 2))
vp3 = viewport(width=0.8, height=0.8, x = 0.5, y = 0.5)
p <- qplot(mpg, data=mtcars, geom="density")
print(p, vp = vp3)

library(rsm)
ccd.design <- ccd(3,n0=c(3,3),alpha = "rotatable",randomize = F,inscribed = F,oneblock = T) 
y <- c(66,80,78,100,70,70,60,75,113,100,118,100,80,68,63,65,82,88,100,85)
ccd.design$y <- y 
SO.ccd <- rsm(y~SO(x1,x2,x3),data = ccd.design)
summary(SO.ccd) 
SO.ccd <- rsm(y~SO(x1,x2,x3),data = ccd.design)
summary(SO.ccd) 
persp(SO.ccd,x2~x3,contours = list(z="bottom")) 

library(readxl)
library(tidyverse)
library(ggplot2)
X07 <- read_excel("07.xlsx",col_names = FALSE)
PTZ <- read_excel("PTZ.xlsx")
select(X07,c("...1","...4","...5","...6")) -> f
colnames(f) <- c("group","sig","ns","p")
apply(a,2,mean, na.rm = TRUE) -> f2
cbind(f,f2) -> f2
packing2<- circleProgressiveLayout(f2$f2, sizetype='area')
f2 <- cbind(f2, packing2)
dat.gg <- circleLayoutVertices(packing2, npoints=90)

f2$sig <- case_when(f$sig == "Yes" ~ "red",
                   f$sig == "No" ~ "blue",
                 TRUE ~ NA_character_)

ggplot() + 
  geom_polygon_interactive(data = dat.gg, aes(x, y, group = id, fill=id, tooltip = data$text[id], data_id = id), colour = "black", alpha = 0.6, inherit.aes=FALSE) +
  scale_fill_viridis() +
  geom_text(data = f2, aes(x, y, label = gsub("PTZ vs.", "", group)), size= f2$f2/300, color= f2$sig) +
  theme_void() + 
  theme(legend.position="none", plot.margin=unit(c(0,0,0,0),"cm") ) + 
  coord_equal()

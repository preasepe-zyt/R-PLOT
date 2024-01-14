library(ggplot2)
library(tidyverse)
data <- data.frame(
  Group=c(rep(paste0("G",1:3),100)),
  Class=c(rep(paste0("Class ",1:6),each=50)),
  Pos=c(rep(1:16,each=3),17,18),
  value=runif(300,1,10),
  addtion=1:300
)

plot <- ggplot(data, aes(x = Pos, y = Group)) +
  geom_tile(aes(fill = value), colour = "white") +
  scale_fill_gradient(low="white", high="#22a6b3") +
  facet_wrap(~ Class, ncol = 2, scales = "free") +
  scale_x_continuous(breaks = seq(0,60,2),expand = c(0, 0))+
  geom_text(aes(label=str_sub(value,1,1)),color='#f1f2f6') +
  theme_classic()+
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    strip.background = element_rect(fill = "#ffffff"),
    strip.text = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 12, color = "black"),
    axis.title = element_text(size = 14, face = "bold"),
    legend.position = "right",
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10)
  )
plot

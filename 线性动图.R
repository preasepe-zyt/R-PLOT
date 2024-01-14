library(ggplot2)
library(gganimate)
library(babynames)
library(hrbrthemes)
library(tidyverse)
# Keep only 3 names
don <- babynames %>% 
  filter(name %in% c("Ashley", "Patricia", "Helen")) %>%
  filter(sex=="F")

# Plot
don %>%
  ggplot( aes(x=year, y=n, group=name, color=name)) +
  geom_line() +
  geom_point() +
  scale_color_viridis(discrete = TRUE) +
  ggtitle("可以换成斑马鱼的折线图") +
  theme_ipsum() +
  ylab("换成斑马鱼的数据") +
  transition_reveal(year)

library(RColorBrewer)
library(grid)
color <- colorRampPalette(brewer.pal(11,"RdBu"))(15)

grid.raster(scales::alpha(color, 0.3), 
            width = unit(1, "npc"), 
            height = unit(1,"npc"),
            interpolate = T)

don$name  <- case_when(don$name == "Helen" ~ "不太聪明的鱼",
                       don$name == "Patricia" ~ "小机灵鬼鱼",
                       don$name == "Ashley"~ "吃药太多的鱼",
                 TRUE ~ NA_character_)


# Save at gif:
anim_save("287-smooth-animation-with-tweenr.gif")


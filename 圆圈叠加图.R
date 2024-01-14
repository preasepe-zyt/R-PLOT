library(tidyverse)
logp <- read.csv("C:/Users/79403/Desktop/药物筛选/plot/logp.csv")

pdf(file="Clogp.pdf",width = 10,height = 10,family = "sans")
plt <- ggplot(logp, fill=CLogP) +
  # Add bars to represent the cumulative track lengths
  # str_wrap(cluster, 5) wraps the text so each line has at most 5 characters
  # (but it doesn't break long words!)
  geom_col(
    aes(
      x = reorder(str_wrap(cluster, 5), CLogP),
      y = CLogP,fill=CLogP
    ),
    position = "dodge2",
    show.legend = TRUE,
    alpha = .9,
    
  ) +
  # Add dots to represent the mean gain
  geom_point(
    aes(
      x = reorder(str_wrap(cluster, 5),CLogP),
      y = CLogP
    ),
    size = 3
  ) +
  # Make it circular!
  coord_polar()+
  scale_fill_gradientn(
    "LogP",
    colours = c( "#6C5B7B","#C06C84","#F67280","#F8B195")
  )+ 
  geom_segment(
    aes(
      x = reorder(str_wrap(cluster, 5), CLogP),
      y = 0,
      xend = reorder(str_wrap(cluster, 5), CLogP),
      yend = 5
    ),
    linetype = "dashed",
    color = "gray12")+
  theme(
    # Remove axis ticks and text
    text = element_text(family = "sans"),
    axis.title = element_blank(),
    axis.ticks = element_blank(),
    axis.text.y = element_blank(),
    # Use gray text for the cluster names
    axis.text.x = element_text(color = "gray12", size = 25),
    # Move the legend to the bottom
    legend.position = "top",
    legend.key.size = unit(1.5, "cm"),
    legend.text = element_text(size= 25),
    legend.title= element_text(size= 25)
  )
plt
dev.off()



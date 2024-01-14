theme_set(
  theme_bw() +
    theme(panel.grid.major = element_blank(),
          axis.text = element_text(size = 8))
)

shabitu %>% ggplot()+geom_bar(aes(x=group, y=b, fill=group), stat='identity',show.legend = F)+
  coord_flip()+xlab("") + 
  ylab("人数")+
  labs(title = "人口统计学结果")+
  theme(plot.title = element_text(hjust = 0.5),
        legend.title=element_blank(),
        )+
    geom_rect(aes(xmin="男",
            xmax="大城市",
            ymin=0,
            ymax=155,fill=shabitu$group),alpha=0.01)+
  scale_y_continuous(expand = c(0,0))+
  scale_x_discrete(expand = c(0,0))+
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        axis.text = element_text(size = 8))
y_lim <- 20 # a custom threshold for the horizontal line
y_lim <- 20
ggplot() +
  geom_point(data = mtcars,
             aes(x = hp, y = mpg)) +
  geom_hline(yintercept = y_lim) +
  # Shade area under y_lim
  geom_rect(aes(xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = y_lim),
            alpha = 1/5,
            fill = "blue") +
  # Shade area above y_lim
  geom_rect(aes(xmin = -Inf, xmax = Inf, ymin = y_lim, ymax = Inf),
            alpha = 1/5,
            fill = "red")

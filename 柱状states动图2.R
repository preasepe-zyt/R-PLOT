library(gganimate)
library(ggplot2)
library(gapminder)
library(tidyverse)
rm(list=ls())


pu <- read.csv2("C:/Users/79403/Desktop/Cosmetics.csv", sep=",")
pu <- pu[,-c(2:4)] %>%
    as.data.frame()
pu <- pu[-23,]
pu <- pu[-23,]
make<- function(x) {
    return(as.numeric(x*3))
}
pu$Count <- map(pu$Count,make) %>%
    unlist()
options(gganimate.dev_args = list(width = 1000, height = 500))
a <- pu %>% ggplot() +
    geom_bar(pu,stat='identity',position="dodge", mapping=aes(Year,Count,fill = Count))+
    ggtitle("斑马鱼与化妆品相关的文献资料发表数量 (1999-2022)") +
    theme_classic() +
    labs(fill="文献资料发表数量",y="文献资料发表数量",x="Year: {previous_state}")+
    theme(plot.title = element_text(hjust = 0.8),
          text = element_text(size = 20),
          axis.text.x =element_text(size = 20,angle =45,hjust = 1),
          axis.text.y =element_text(size = 20),
          axis.title.x = element_text(color="red",vjust = 80,hjust = 0.1),
          axis.title.y = element_text(margin = margin(r = 20)),
          axis.line = element_line(size = 1),
          axis.ticks.length = unit(0.2, "cm"),
          axis.ticks = element_line(size = 1))+
    geom_text(aes(Year,Count,label=Count), show.legend = F,size=4,color="black",vjust = -0.3)+
    scale_x_continuous(breaks = pu$Year,labels = pu$Year)+
    scale_fill_gradient(low ="#386CB0" ,high = "#E64B35CC")+
    scale_y_continuous(limits = c(0,300),expand = c(0,0))
a
    
p <- a +transition_states(Year,transition_length = 0.1, state_length = 0.1)+
                     shadow_mark(size = 6)

anim <- animate(p, nframes = 100, fps = 10, duration = 1, end_pause = 1)
anim_save(filename = '2022.gif')

library(gganimate)
library(ggplot2)
library(gapminder)
library(tidyverse)


fct_inorder(finance$x) -> finance$x
fct_inorder(finance$la) -> finance$la

a <- finance %>% ggplot() +
    geom_bar(finance,stat='identity',position="dodge", mapping=aes(year,x,fill=seq(x)), show.legend = F)+
    ggtitle("") +
    theme_classic()+
    labs(fill="",y="经济效益(亿)",x="")+
    geom_line(finance,mapping=aes(year,x),colour="#CC78A6",size=5)+
    geom_point(finance, mapping=aes(year,x),size=4)+
    theme(#plot.title = element_text(hjust = 0.9),
          text = element_text(size = 30),
          axis.text.x =element_text(size = 30),
          axis.text.y =element_text(size = 30)
          )+
    #scale_x_continuous(breaks=c(1,2,3,4,5,6),labels= c("","1亿","2亿","5亿","8亿","10亿"))+
    scale_y_continuous(breaks=c(0,2.5,5,7.5,10),labels= c("0亿","2.5亿","5亿","7.5亿","10亿"))+
    geom_text(finance,mapping=aes(year,x+1,label= la), show.legend = F,size=7)+
    transition_reveal(year)+
    shadow_mark(size=7)
    
a
animate(a,nframes = 65,width=800,height=500,end_pause=2)



anim_save(filename = "7.gif")
xlsx::write.xlsx(finance,"7秒.xlsx")

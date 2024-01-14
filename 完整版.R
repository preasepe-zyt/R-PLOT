top_bar <- function(x){  
  return(mean(x)+sd(x)) 
}
bottom_bar <- function(x){
  return(mean(x)-sd(x))
}
ggplot(bnc,aes(con,mortality,group=con))+
  theme_classic()+
  stat_summary(geom = 'point',size=3)+
  stat_summary(geom = 'errorbar',width=.05,cex=0.5,
               fun.min = bottom_bar,fun.max = top_bar)+
  stat_smooth(se=F,method = 'gam',cex=0.5)+
  scale_x_log10(expand=c(0,0.2))+
  scale_y_continuous(limits = c(-20,130),
                     breaks = seq(-20,130,10),
                     labels = c(-20,'',0,'',20,'',40,'',
                                60,'',80,'',100,'',120,''),
                     expand = c(0,0))+
  scale_color_manual(values = c('#fd0201','#00ff01',
                                '#0000fd','#ff00ff'))+
  scale_shape_manual(values = c(15,16,17,18))+
  labs(x='cmpd.concentration (μM)',y='bound / total (%)',
       title = 'LC3-compound MST')+
  theme_classic(base_size = 25)+
  theme(legend.position = c(0.12,0.9),
        plot.title = element_text(hjust = 0.5),
        legend.title = element_blank(),
        axis.text = element_text(color = 'black'))+
  annotation_logticks(sides = "b", outside = TRUE,
                      short = unit(2,"mm"),
                      mid = unit(2,"mm"),
                      long = unit(3,"mm"),
                      size = 1)+
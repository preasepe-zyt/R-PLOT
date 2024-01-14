ggplot()+
  geom_bar(data=al2,mapping=aes(x=group,y=mean,fill=sig,color= sig),inherit.aes=FALSE, stat="identity",width = 0.8,position="dodge",alpha=0.6)+
  coord_polar()+
  theme(panel.grid = element_blank(), 
        panel.background = element_blank(),
        axis.ticks = element_blank(), 
        axis.text = element_blank(), 
        axis.title = element_blank()
  )+
  geom_text(data = al2,
            aes(x = group, 
                y = 800,
                label = group
            ),fontface="bold",
            inherit.aes = FALSE,size = 3) -> gao

            
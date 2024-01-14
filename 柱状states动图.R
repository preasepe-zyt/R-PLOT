options(gganimate.dev_args = list(width = 1000, height = 500))
a <- pu %>% ggplot() +
    geom_bar(pu,stat='identity',position="dodge", mapping=aes(Year,Count,fill = Count))+
    ggtitle("斑马鱼与化妆品相关的文献资料发表数量") +
    theme_classic() +
    labs(fill="文献资料发表数量",y="文献资料发表数量",x="Year: {previous_state}",size=20)+
    xlim(1990,2023)+
    theme(plot.title = element_text(hjust = 1.5,size=5),
          axis.title= element_text(size=20, family="myFont",color="black", face= "bold"))+
    geom_text(aes(Year,Count+3,label=Count), show.legend = F,size=3.5,color="black")
a
    
a +transition_states(Year,
                     transition_length=0.1,
                     state_length=0.1) + 
    shadow_mark(size = 5)
anim_save(filename = 'second.gif')

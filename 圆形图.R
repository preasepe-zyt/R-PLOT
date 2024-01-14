ggplot(al,aes(group, x,color=sig))+
    theme_classic()+
    geom_bar(al,mapping=aes(group, x,color=sig,fill=sig),alpha=0.7, stat="identity",inherit.aes=FALSE)+
    coord_polar()+
    ylim(0,180)
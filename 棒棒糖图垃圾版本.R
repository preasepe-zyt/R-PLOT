all$`affinity (kcal/mol)` <- round(all$`affinity (kcal/mol)`,2)
pdf(file="ligand.pdf",height=8,width=12,family = "Arial")
ggplot(all ,aes(x=ligand ,y=`affinity (kcal/mol)`))+
    geom_point(aes(size=abs(`affinity (kcal/mol)`),color=`affinity (kcal/mol)`))+
    scale_size(rang = c(0,8))+
    scale_color_viridis_c()+  
    geom_segment(aes(x=ligand ,xend=ligand ,y=0,yend=`affinity (kcal/mol)`),
                 size=1,linetype="solid")+
    labs(x="", y='Affinity (kcal/mol)',title = 'Docking')+
    coord_flip()+
    theme_bw()+
    labs(size="Affinity (kcal/mol)",
         color="Affinity (kcal/mol)")+
    mytheme
dev.off()
if(T){mytheme <- theme(plot.title = element_text(size = 20,color="black",hjust = 0.5),
                     axis.title = element_text(size = 20,color ="black"), 
                     axis.text = element_text(size= 20,color = "black"),
                     panel.grid.minor.y = element_blank(),
                     panel.grid.minor.x = element_blank(),
                     axis.text.x = element_text(angle = 0, hjust = 1 ),
                     panel.grid=element_blank(),
                     legend.position = "right",
                     legend.text = element_text(size= 20),
                     legend.title= element_text(size= 20)
) }

all <- edit(all)

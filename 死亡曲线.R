c(rep("Ctl",1),rep("30 μg/mL",1),rep("60 μg/mL",1),rep("100 μg/mL",1),rep("120 μg/mL",1),rep("150 μg/ml",1)) -> group1
library(ggplot2)
ggplot(x,aes(group,mean),group=group)+
    geom_point()+
    geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd))+
    theme_classic()+
    geom_smooth(se=T,color="black")+ 
    labs(x = "Concentrations (μg/mL)", y = "Mortality(100%)")+
    geom_hline(aes(yintercept = 50),linetype="dashed", size=1.2, colour="gray56")+
    xlim(,1000)+
    geom_label(aes(label = con),  nudge_y = 2,  alpha = 0.5  )+
    annotate("text",x = c(-271,-250), y = c(75,90), label = c("LC 1 = 30 μg/mL","LC 50 = 150 μg/mL"), size = 5, colour = "black")


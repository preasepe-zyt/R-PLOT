library(ggplot2)
library(aplot)
library(tidyverse)
X1141 <- read_excel("1141.xlsx", col_names = FALSE) 
names(X1141) <- c("group", "a", "b", "sig2", "sig", "c", "d", "mean", "sd")
str_split(X1141$group, " ", simplify = T)[,3] %>% fct_inorder()  -> X1141$group
X1141 %>% arrange(desc(X1141$group)) %>% fct_inorder() -> X1141
X1141$sig[c(28,29)] <- 
X1141$sig <- ifelse(str_detect(X1141$sig != "ns"),"#"," ")
ggplot(X1141,aes(group,mean,color=sig2))+
    theme_classic()+
    geom_point(X1141,mapping=aes(group, mean),size=4)+
    geom_errorbar(X1141,mapping=aes(x = group,ymin=mean-sd, ymax=mean+sd),width=0.5,inherit.aes = FALSE)+
    coord_flip()+
    geom_text(aes(group,mean + (sd+50),label=sig), show.legend = F,size=3,color="black")+
    geom_text(aes(group,mean + (sd+50),label=ns3), show.legend = F,size=6,color="black")+
    #geom_hline(yintercept = 233.19, linewidth = 0.3,linetype="dashed")+
    labs(x = "Samples", y = "Total distance (cm)")+
    labs(color = "Sample vs. PTZ",shape = "Sample vs. PTZ")+
    theme(panel.background = element_rect(fill=c("#FFF6E1")))+
    ylim(0,1000)-> p1
    

    


    geom_rect(xmin = c("Ctl","VPA","6B9"),
              xmax = c("VPA","6B9","6B6"),
              ymin = 0, ymax = 1000, alpha = 0.01)
    annotate("rect",
           xmin = c("Ctl","VPA","6B9"),
           xmax = c("VPA","6B9","6B6"),
           ymin = -100, ymax = 1000, alpha = 0.01)
    geom_tile(aes(group, 1, fill = al), alpha = 0.3)

ggplot(X1141) +geom_tile(aes(group,1,color=sig2,fill=sig2), alpha = 0.5)+
  coord_flip()+
  #scale_y_continuous(expand = expansion(mult = c(5,5.5)))
  theme(panel.grid = element_blank(), 
        panel.background = element_blank(),
        axis.ticks = element_blank(), 
        axis.text = element_blank(), 
        axis.title = element_blank(),
        ) + labs(color = "Sample (alone) vs. Ctl",fill = "Sample (alone) vs. Ctl") -> p2
library(tidyverse) 
p1%>%insert_right(p2,width =0.09) 
p1%>%insert_right(p2,width = 0.5)
p2+p1
p2/p1 + p2/p1
p1+annotation_custom(p2)
p1%>%insert_right(p2,width = 0.5)
p1+annotation_custom(p2,xmin="6D6",xmax="VPA",ymin=0,ymax=1000)



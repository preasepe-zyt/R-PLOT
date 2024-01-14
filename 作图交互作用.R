library(ggplot2)
library(ggpubr)
ggplot(data, mapping = aes(x=心理资本, y=选课态度,color=心理资本,group=心理资本,linetype=说服信息))+
    geom_point()+
    theme_classic()+
    geom_line(aes(group=说服信息),size=1,stat = "identity")+
    theme(text=element_text(size=15,
                            family = "SimSun",
                            face = "bold",
                            color = "black"),
          axis.text.y = element_text(size= 15,color = "black",face= "bold"),
          axis.text.x = element_text(size= 15,color = "black",face= "bold"),
          legend.text = element_text(size= 15,face= "bold"),
          legend.title= element_text(size= 15,face= "bold"),
          #axis.text.x.top = element_text(size= 30,face= "bold"),
          #axis.text.y.left = element_text(size= 30,face= "bold"),
          #strip.text.x = element_text(size = 30, face = "bold"),
          strip.text.y = element_text(size = 15, face = "bold"))+
    scale_y_continuous(breaks = c(5,10,15,20,25,30,35,40,45,50,60))+
    geom_text(aes(label = 选课态度, vjust = -1.5, hjust = 1.2), show_guide = FALSE,size=6) 

ggplot(data2, mapping = aes(x=心理资本, y=选课态度,color=心理资本,group=心理资本),na.rm = T)+
    geom_boxplot()+
    theme_classic()+
    theme(text=element_text(size=15,
                            family = "SimSun",
                            face = "bold",
                            color = "black"),
          axis.text.y = element_text(size= 15,color = "black",face= "bold"),
          axis.text.x = element_text(size= 15,color = "black",face= "bold"),
          legend.text = element_text(size= 15,face= "bold"),
          legend.title= element_text(size= 15,face= "bold"),
          #axis.text.x.top = element_text(size= 30,face= "bold"),
          #axis.text.y.left = element_text(size= 30,face= "bold"),
          #strip.text.x = element_text(size = 30, face = "bold"),
          strip.text.y = element_text(size = 15, face = "bold"))+
    scale_y_continuous(breaks = c(5,10,15,20,25,30,35,40,45,50,60)) -> p

ggplot(data2, mapping = aes(x=说服信息, y=选课态度,color=说服信息,group=说服信息),na.rm = T)+
    geom_boxplot()+
    theme_classic()+
    theme(text=element_text(size=15,
                            family = "SimSun",
                            face = "bold",
                            color = "black"),
          axis.text.y = element_text(size= 15,color = "black",face= "bold"),
          axis.text.x = element_text(size= 15,color = "black",face= "bold"),
          legend.text = element_text(size= 15,face= "bold"),
          legend.title= element_text(size= 15,face= "bold"),
          #axis.text.x.top = element_text(size= 30,face= "bold"),
          #axis.text.y.left = element_text(size= 30,face= "bold"),
          #strip.text.x = element_text(size = 30, face = "bold"),
          strip.text.y = element_text(size = 15, face = "bold"))+
    scale_y_continuous(breaks = c(5,10,15,20,25,30,35,40,45,50,60)) -> p2


ggplot(data2, mapping = aes(x=课程难度, y=选课态度,color=课程难度,group=课程难度),na.rm = T)+
    geom_boxplot()+
    theme_classic()+
    theme(text=element_text(size=15,
                            family = "SimSun",
                            face = "bold",
                            color = "black"),
          axis.text.y = element_text(size= 15,color = "black",face= "bold"),
          axis.text.x = element_text(size= 15,color = "black",face= "bold"),
          legend.text = element_text(size= 15,face= "bold"),
          legend.title= element_text(size= 15,face= "bold"),
          #axis.text.x.top = element_text(size= 30,face= "bold"),
          #axis.text.y.left = element_text(size= 30,face= "bold"),
          #strip.text.x = element_text(size = 30, face = "bold"),
          strip.text.y = element_text(size = 15, face = "bold"))+
    scale_y_continuous(breaks = c(5,10,15,20,25,30,35,40,45,50,60)) -> p3
p/p2/p3
library(aplot)

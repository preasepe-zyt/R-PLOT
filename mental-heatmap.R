devtools::install_github("Hy4m/linkET",force = TRUE)
library(tidyverse)
library(linkET)
library(RColorBrewer)

data("varechem", package = "vegan")
data("varespec", package = "vegan")

mantel <- mantel_test(varespec,varechem,spec_select = list(depress = 1:7,disease = 8:18,comorbidty = 19:37,anxiety = 38:44))
mutate(rd = cut(r, breaks = c(-Inf, 0.2, 0.4, Inf),labels = c("< 0.2", "0.2 - 0.4", ">= 0.4")),
pd = cut(p, breaks = c(-Inf, 0.01, 0.05, Inf),labels = c("< 0.01", "0.01 - 0.05", ">= 0.05")))
qcorrplot(correlate(varechem,method = "pearson"),diag=F,type="upper")+
geom_tile()+# 绘制相关性
# 添加几何对象 
#geom_mark(size=2.5,sig.thres=0.05,sep="\n") + # 添加p值

geom_couple(aes(colour=pd,size=rd),data=mantel,label.colour = "black",
              curvature=nice_curvature(0.15), #设置曲线角度
              nudge_x=0.2, # 设置标签文本与曲线距离
              label.fontface=2, # 标签设置字体粗细
              label.size =4,  # 设置标签大小
              drop = T)+
  scale_fill_gradientn(colours = RColorBrewer::brewer.pal(11,"RdBu"))+
  scale_size_manual(values = c(0.5, 1, 2)) +
  scale_colour_manual(values =c("#D95F02","#1B9E77","#A2A2A288")) +
  guides(size = guide_legend(title = "Mantel's r",override.aes = list(colour = "grey35"), order = 2),
         colour = guide_legend(title = "Mantel's p",override.aes = list(size = 3), order = 1),
         fill = guide_colorbar(title = "pearson's r",order = 3))+
theme(plot.margin = unit(c(0.1,0.1,0,0.1),units = "cm"),
        legend.background=element_blank(),
        legend.key = element_blank(),axis.text=element_text(color="black",size=10)) 
        

        
  
        
        
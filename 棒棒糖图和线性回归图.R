install.packages("rlang")
install.packages("ggplot2")
library(ggplot2)
library(ggpubr)
ggscatter(iris_input, Sepal.Length, Petal.Width, 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Miles/(US) gallon", ylab = "Weight (1000 lbs)")

setwd("D:/生物信息学/棒棒糖图")
A <- read.csv("df.csv", header = T)
library(forcats)
A$pathway <- as.factor(A$pathway)
A$pathway <- fct_inorder(A$pathway)
#初步作图

p <- ggplot(A,aes(x=pathway,y=corr))+
  geom_point(data=A,aes(size=abs(corr),color=Pval))+
  scale_size(rang = c(0,8))+
  scale_color_viridis_c()+  
  geom_segment(aes(x=pathway,xend=pathway,y=0,yend=corr),
               size=1,linetype="solid")+
  labs(x="", y='Correlation(r)',title = 'Gene')+
  coord_flip()+
  theme_bw()+
  theme(axis.text.x=element_text(angle=90,hjust = 1,vjust=0.5),
        panel.border = element_blank(),
        axis.text =element_text(size = 10, color = "black"),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust=0.5))
p
#叠加图层，让棒棒位于点以下。
p1 <- p +geom_point(data=A,aes(size=abs(corr),color=Pval))+
  scale_color_viridis_c()
p1
# 修改
p2 <- p1+guides(color='none')+
  guides(size=guide_legend(title="Correlation"))
p2
#增加
p2 + annotate(geom = "text", x = unique(A$pathway),
              label = A$Pval,
              y =1.1, hjust = 0)
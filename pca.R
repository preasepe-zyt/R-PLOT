library(readxl)
PCR_1 <- read_excel("PCR-1.xlsx")
autodock <- read_excel("autodock.xlsx")
autodock -> a
zoo::na.spline(a)->a
library(pheatmap)
library(factoextra)
library(ggplot2)
library(ggrepel)

pca1 <- prcomp(b[,-1])


df1 <- pca1$x # 提取PC score
df1 <- as.data.frame(df1) # 注意：如果不转成数据框形式后续绘图时会报错

summ1 <- summary(pca1)
summ1

# 提取主成分的方差贡献率,生成坐标轴标题
summ1 <- summary(pca1)
xlab1 <- paste0("PC1(",round(summ1$importance[2,1]*100,2),"%)")
ylab1 <- paste0("PC2(",round(summ1$importance[2,2]*100,2),"%)")
library(ggplot2)
ggplot(data = df1,aes(x = PC1,y = PC2 ,color = b$...1))+
  # 绘制置信椭圆：
  stat_ellipse(aes(fill = b$...1),
               type = "norm",geom = "polygon",alpha = 0.25,color = NA)+ 
  # 绘制散点：
  geom_point(size = 3.5)+
  geom_line()+
  labs(x = xlab1,y = ylab1,color = "Condition",title = "PCA Scores Plot")+
  guides(fill = "none")+
  theme_bw()+
  # 可以通过以下两行代码设置置信圆和散点的颜色:
  #scale_fill_manual(values = c("purple","orange","pink"))+
  #scale_colour_manual(values = c("purple","orange","pink"))+
  theme(plot.title = element_text(hjust = 0.5,size = 15),
        axis.text = element_text(size = 11),axis.title = element_text(size = 13),
        legend.text = element_text(size = 11),legend.title = element_text(size = 13),
        plot.margin = unit(c(0.4,0.4,0.4,0.4),'cm'))

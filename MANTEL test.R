library(corrplot)
library(vegan)
library(dplyr)

cor_plot<-cor(ug_25)
corrplot(cor_plot,method = "color" ,type = "upper",addrect = 1,insig="blank",rect.col = "blue",rect.lwd = 2)


devtools::install_git("https://gitee.com/dr_yingli/ggcor") 
library(vegan)
library(ggcor)
mantel <- mantel_test(CTL, ug_25, #调用vegan包中的内置数据，见上方解释
                      spec.select = list(Spec01 = 1:3,#依次定义四种物种作为Mantel的分析对象
                                         Spec02 = 4:7,
                                         Spec03 = 7:10,
                                         Spec04 = 10:16))%>% 
mutate(rd = cut(r, breaks = c(-Inf, 0.2, 0.4, Inf),
                  labels = c("< 0.2", "0.2 - 0.4", ">= 0.4")),#定义Mantel的R值范围标签，便于出图
                  pd = cut(p.value, breaks = c(-Inf, 0.01, 0.05, Inf),
                  labels = c("< 0.01", "0.01 - 0.05", ">= 0.05")))#定义Mantel检验的p值范围标签，便于出图
quickcor(CTL, type = "upper") +#绘制理化数据热图
  geom_square() +#定义成方块状
  anno_link(aes(colour = pd, size = rd), data = mantel) +#定义连线
  scale_size_manual(values = c(0.5, 1, 2))+
  guides(size = guide_legend(title = "Mantel's r",#定义图例
                             order = 2),
         colour = guide_legend(title = "Mantel's p", 
                               order = 3),
         fill = guide_colorbar(title = "Pearson's r", order = 4))

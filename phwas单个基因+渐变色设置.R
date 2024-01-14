library(ggplot2)
library(extrafont)
loadfonts(device = "pdf")
#导入字体进入pdf
#showtext包可给定字体文件，加载到 R环境中，生成新的字体家族名字，后期调用这个名字设定字体，并且支持中文写入pdf不乱码

library(showtext)
showtext_auto(enable=TRUE)
font_add("Arial","simkai.ttf")

pdf(file="单个基因的phwas.pdf",height=8,width=20,family = "Arial")
ggplot()+
  geom_point(ALOX5,mapping=aes(Domain,N,color=P.value))+
  scale_color_gradient(low = "#386CB0", high = "#E64B35CC")+
  theme_classic()+
  mytheme+
  labs(x="",y="Number Of Related Trait")
dev.off()


if(T){mytheme <- theme(plot.title = element_text(size = 20,color="black",hjust = 0.5),
                       axis.title = element_text(size = 20,color ="black"), 
                       axis.text = element_text(size= 20,color = "black"),
                       panel.grid.minor.y = element_blank(),
                       panel.grid.minor.x = element_blank(),
                       axis.text.x = element_text(angle = 45, hjust = 1 ),
                       panel.grid=element_blank(),
                       legend.position = "right",
                       legend.text = element_text(size= 20),
                       legend.title= element_text(size= 20)
) }

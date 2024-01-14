library(tidyverse)
library(ggplot2)
library(extrafont)
loadfonts(device = "pdf")
library(corrplot)
#导入字体进入pdf
#showtext包可给定字体文件，加载到 R环境中，生成新的字体家族名字，后期调用这个名字设定字体，并且支持中文写入pdf不乱码
library(showtext)
showtext_auto(enable=TRUE)
train <- read.csv("C:/Users/79403/Desktop/时瑞蝶/外部验证/train.txt", row.names=1)
train %>% select(c(1,2,3,4,6)) %>% cbind(T_cells_CD8=pdata2$T_cells_CD8) %>% rename(AD=group_list) -> train2
comcor<-cor(box)
#计算显著性差异
comp<-cor.mtest(comcor,conf.level=0.95)
pval<-comp$p
#获取目标基因相关性矩阵
goalcor<-select(as.data.frame(comcor),c("group"))%>%rownames_to_column(var="celltype")

##长宽数据转换
goalcor<-melt(goalcor,id.vars="celltype")
colnames(goalcor)<-c("celltype","Gene","correlation")
#获取目标基因集pvalue矩阵
pval<-select(as.data.frame(pval),"group")%>%rownames_to_column(var="celltype")

#长宽数据转换
pval<-melt(pval,id.vars="celltype")
colnames(pval)<-c("celltype","gene","pvalue")
#将pvalue和correlation两个文件合并
final<-left_join(goalcor,pval,by=c("celltype"="celltype","Gene"="gene"))
#5.开始绘图

#添加一列,来判断pvalue值范围
final$sign<-case_when(final$pvalue >0.05~">0.05",
                      final$pvalue <0.05 &final$pvalue>0.01 ~"<0.05",
                      final$pvalue <0.01 &final$pvalue>0.001 ~"<0.01",
                      final$pvalue <0.001 &final$pvalue>0.0001~"<0.001",
                      final$pvalue <0.0001 ~"<0.0001")
#添加一列来判断correlation的正负
final$core<-case_when(final$correlation >0 ~"positive",
                      final$correlation<0 ~"negtive")
pdf("bubble.pdf",width=7,height = 8,family = "serif")
#开始绘图
ggplot(data=final,aes(x=Gene,y=celltype))+
    #筛选正相关的点
    geom_point(data=filter(final,core=="positive"),aes(x=Gene,y=celltype,size=abs(correlation),fill=sign),shape=21)+
    #筛选负相关的点
    geom_point(data=filter(final,core=="negtive"),
               aes(x=Gene,y=celltype,size=abs(correlation),color=sign),shape=16)+
    #自定义颜色
    scale_color_manual(values=c("#333366","#CCCCCC"))+
    #自定义填充颜色
    scale_fill_manual(values=c("#FF6666","#FF9999","#CCCCCC"))+
    #去除x轴和y轴
    labs(x="",y="")+
    #修改主题
    theme_bw()+
    mytheme+
    #修改legend,title表示标题，order表示标题的顺序，override.aes来设置大小
    guides(color=guide_legend(title="Negitive\ncorrelation\nFDR q-value",order=1,override.aes=list(size=4)),
           size=guide_legend(title="Spearman's p",order=2),
           fill=guide_legend(title="Positive\ncorrelation\nFDR q-value",order=3,override.aes=list(size=4)))
#保存图片
dev.off()


if(T){mytheme <- theme(text = element_text(family="serif"),
                       plot.title = element_text(size = 20,color="black",hjust = 0.5,family="serif"),
                       axis.title = element_text(size = 20,color ="black", family="serif"), 
                       axis.text = element_text(size= 20,color = "black", family="serif"),
                       #panel.grid.minor.y = element_blank(),
                       #panel.grid.minor.x = element_blank(),
                       axis.text.x = element_text(angle = 45,hjust = 1,family="serif" ),
                       #panel.grid=element_blank(),
                       legend.position = "right",
                       legend.text = element_text(size= 20, family="serif"),
                       legend.title= element_text(size= 20, family="serif"),
                       axis.text.y = element_text(margin = margin(0,0,0,0.2,'cm')),
                       axis.ticks.length.y = unit(0.25, "cm")
                       #axis.ticks = element_line(linewidth = 2,size = 2)
) }

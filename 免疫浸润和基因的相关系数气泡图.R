#安装需要的R包
install.packages("ggplot2")
install.packages("tidyverse")
install.packages("ggrepel")
install.packages("corrplot")
install.pachages("reshape2")
#2.载入需要的R包

library(ggplot2)
library(tidyverse)
library(ggrepel)
library(corrplot)
library(reshape2)
#3.读取数据

#读取基因表达矩阵文件
exp<-read.csv("expr.csv",header=T,row.names=1,check.names=F,stringsAsFactors = FALSE)
#读取ssGSEA分析结果文件
gsea<-read.csv("ssGSEA.csv",header=T,row.names=1,check.names=F,stringsAsFactors = FALSE)
#4.代码展示
exp <- ids_exprs
#目标基因集
genelist<- target_genes$x
#提取基因集的表达矩阵
goal_exp<-filter(exp,rownames(exp) %in%genelist)
exp <- goal_exp
#合并目标基因集表达矩阵和免疫细胞矩阵
combine<-rbind(immune,exp)
#计算相关系数
comcor<-cor(t(combine))
#计算显著性差异
comp<-cor.mtest(comcor,conf.level=0.95)
pval<-comp$p
#获取目标基因相关性矩阵
goalcor<-select(as.data.frame(comcor),genelist)%>%rownames_to_column(var="celltype")
goalcor<-filter(goalcor,!(celltype %in% genelist))
##长宽数据转换
goalcor<-melt(goalcor,id.vars="celltype")
colnames(goalcor)<-c("celltype","Gene","correlation")
#获取目标基因集pvalue矩阵
pval<-select(as.data.frame(pval),genelist)%>%rownames_to_column(var="celltype")
pval<-filter(pval,!(celltype %in% genelist))
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
    theme(axis.text.x=element_text(angle=45,hjust=1),
          axis.ticks.x=element_blank())+
    #修改legend,title表示标题，order表示标题的顺序，override.aes来设置大小
    guides(color=guide_legend(title="Negitive\ncorrelation\nFDR q-value",order=1,override.aes=list(size=4)),
           size=guide_legend(title="Spearman's p",order=2),
           fill=guide_legend(title="Positive\ncorrelation\nFDR q-value",order=3,override.aes=list(size=4)))
#保存图片
ggsave("correlation.pdf",width=9,height=10)

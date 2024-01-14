library(dplyr)
exp <- arrange(p,desc(AveExpr))
exp2 <- exp %>% distinct(id, .keep_all = TRUE)
dim(exp2)
head(exp2)

library(ggplot2)
library(ggrepel)
#转成tibble便于后续使用，去掉不需要的列；
dt <- as_tibble(exp2[c(6,4,3)])
#对p值取对数；
p$log10PValue <- -log10(p$P.Value)
#生成显著上下调数据的分组标签；
p$group <- case_when(p$logFC > 0.1 & p$P.Value < 0.05 ~"Up",
                      p$logFC < -0.1 & p$P.Value < 0.05 ~"Down",
                      abs(p$logFC) <= 0.1 ~"None",
                      p$P.Value >= 0.05 ~"None")
head(dt)
#重新设置阈值（logFC=1.5），生成显著上下调数据的分组标签；
dt$group2 <- case_when(dt$logFC > 1.5 & dt$adj.P.Val < 0.05 ~ "Up",
                       dt$logFC < -1.5 & dt$adj.P.Val < 0.05 ~ "Down",
                       abs(dt$logFC) <= 1.5 ~ "None",
                       dt$adj.P.Val >= 0.05 ~ "None")
#提取上下调基因；
Up <- filter(p,group=="Up")
up_genes <- Up$id
Down <- filter(p,group=="Down")
down_genes <- Down$id
#确定上下调基因数量；
paste0("The number of up gene is ",length(up_genes))
#[1] "The number of up gene is 2483"
paste0("The number of down gene is ",length(down_genes))
#[1] "The number of down gene is 1165"
top10sig <- filter(deg,Group!="None") %>% distinct(id,.keep_all = T) %>% top_n(10,abs(logFC))
#将差异表达Top10的基因表格拆分成up和down两部分；
up <- filter(top10sig,group=="Up")
down <- filter(top10sig,group=="Down")
#标记差异最显著的十个基因
p$size <- case_when(!(p$id %in% top10sig$id)~ 1,
                     p$id %in% top10sig$id ~ 2)
#提取非Top10的基因表格；
df <- filter(dt,size==1)
#指定绘图顺序,将group列转成因子型；
df$group <- factor(df$group,
                   levels = c("Up","Down","None"),
                   ordered = T)

#开始绘图，建立映射；
p0 <-ggplot(data=deg,aes(logFC,AveExpr,color=label))
#添加散点；
p1 <- p0+geom_point(size=1)
p1
#自定义半透明颜色（红绿）；
mycolor <- c("#FF9999","#99CC00","gray80")
p2 <- p1 + scale_colour_manual(name="",values=alpha(mycolor,0.9))
p2
#继续添加Top10基因对应的点；
p3 <- p2+geom_point(data=up,aes(logFC,log10PValue),
                    color="#FF9999",size=2,alpha=0.9)+
  geom_point(data=down,aes(logFC,log10PValue),
             color="#7cae00",size=2,alpha=0.9)
p3
#expansion函数设置坐标轴范围两端空白区域的大小；mult为“倍数”模式，add为“加性”模式；
p4<-p3+labs(y="-log10 P Value",x="log2FC")+
  scale_y_continuous(expand=expansion(add = c(0.5, 0)),
                     limits = c(0, 12),
                     breaks = c(0,3,6,9,12),
                     label = c("0","3","6","9","12"))+
  scale_x_continuous(limits = c(-12, 12),
                     breaks = c(-8,-4,0,4,8),
                     label = c("-8","-4","0","4","8"))
p4
#添加箭头；
set.seed(007)
p5 <- p4+geom_text_repel(data=top10sig,aes(logFC,log10PValue,label=id),
                         force=20,color="grey20",
                         size=2,
                         point.padding = 0.5,hjust = 0.5,
                         arrow = arrow(length = unit(0.01, "npc"),
                                       type = "open", ends = "last"),
                         segment.color="grey20",
                         segment.size=0.2,
                         segment.alpha=0.8,
                         nudge_x=0,
                         nudge_y=0)
p5
#自定义图表主题，对图表做精细调整；
top.mar=0.2
right.mar=0.2
bottom.mar=0.2
left.mar=0.2
#隐藏纵轴，并对字体样式、坐标轴的粗细、颜色、刻度长度进行限定；
mytheme<-theme_classic()+
  theme(text=element_text(family = "sans",colour ="gray30",size = 10),
        axis.line = element_line(size = 0.6,colour = "gray30"),
        axis.ticks = element_line(size = 0.6,colour = "gray30"),
        axis.ticks.length = unit(1.5,units = "mm"),
        plot.margin=unit(x=c(top.mar,right.mar,bottom.mar,left.mar),
                         units="inches"))
#应用自定义主题；
p5+mytheme
#添加辅助线；
p6 <- p4+geom_hline(yintercept = c(-log10(0.05)),
                    size = 0.5,
                    color = "orange",
                    lty = "dashed")+
  geom_vline(xintercept = c(-1,1),
             size = 0.5,
             color = "orange",
             lty = "dashed")
p6
#添加其他样式的标签；
#为了方便自定义左右区域的标签，这里使用up、down两个独立的子表格；
p7 <- p6+geom_label_repel(
  data = up,aes(logFC,log10PValue,label=id),
  nudge_x = 3,
  nudge_y = -0.8,
  color = "white",
  alpha = 0.9,
  point.padding = 0.5,
  size = 2.5,
  fill = "#96C93D",
  segment.size = 0.5,
  segment.color = "grey50",
  direction = "y",
  hjust = 0.5) +
  geom_label_repel(
    data = down,aes(logFC,log10PValue,label=id),
    nudge_x = -3,
    nudge_y = 0.2,
    color = "white",
    alpha = 0.9,
    point.padding = 0.5,
    size = 2.5,
    fill = "#9881F5",
    segment.size = 0.5,
    segment.color = "grey50",
    direction = "y",
    hjust = 0.5)
#应用自定义主题；
p8 <- p7+mytheme
p8

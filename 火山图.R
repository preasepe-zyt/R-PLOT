library(ggplot2)
library(ggrepel)
library(limma)
#设置或导入分组
group <- factor(c(rep("CTL",3),rep("MPTP", 3)))
design <- model.matrix(~0+group)
colnames(design) <- levels(factor(group))
rownames(design) <- rownames(df)
#差异比较矩阵 High VS Low
compare <- makeContrasts(CTL - MPTP, levels=design)
fit <- lmFit(df, design)
fit2 <- contrasts.fit(fit, compare)
fit3 <- eBayes(fit2)
res <- topTable(fit3, coef=1, number=200)
#筛选 
sig <- subset(res, P.Value < 0.05)
                
#新增一列，将需要显示的label列出
sig$label <- c(rownames(df)[1:6],
               rep("",(nrow(df)-6)))
#设置点的分类
df$Sig <- as.factor(ifelse(-log10(df$P.Value)> -log10(0.05) & abs(df$logFC)>0,
                             ifelse(df$logFC<0,"Down","Up"),"Non"))
#画图+添加标签
ggplot(data = deg,
       aes(x = logFC,y = -log10(P.Value),colour = Group,fill = Group))+
  scale_color_manual(values =c("#80B1D3","#bfc0c1","#FB8072"))+ #改变颜色
  geom_point(alpha = 1, size = 2)+
  scale_size_continuous(range = c(1, 3))+ #指定散点大小渐变
  geom_vline(xintercept = 0, linetype = "dashed") + #横向水平参考线
  geom_hline(yintercept =  -log10(0.05), linetype = "dashed")+ #纵向垂直参考线
  theme_bw()+ theme(panel.grid = element_blank())+ #改变主题
  geom_text_repel(aes(x = logFC, y = -log10(P.Value),label = label), size = 3.5,
                  max.overlaps = 100, key_glyph = draw_key_point)+
  labs(x = "log2FC",y = "-log10(P-value)")+
  theme(axis.text = element_text(size = 11), axis.title = element_text(size = 13),# 坐标轴标签和标题
        legend.text = element_text(size = 11),legend.title = element_text(size = 13)) # 图例标签和标题


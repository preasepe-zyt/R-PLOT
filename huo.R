library(limma)
library(dplyr)
library(readxl)
library(ggpubr)
library(ggthemes)
library(ggplot2)
heatmap_数据_MJ <- read_excel("C:/Users/79403/Desktop/heatmap-数据_MJ.xlsx")
select(heatmap_数据_MJ,-c("Scan_ID","组别")) -> huo
t(huo) -> huo
huo[,1:6]-> df
list3 <- c(rep("MPTP", 3), rep("CTL",3)) %>% factor(., levels = c("CTL", "MPTP"), ordered = F)
list3 <- model.matrix(~factor(list3)+0)  #把group设置成一个model matrix
colnames(list3) <- c("CTL", "MPTP")
#as.data.frame(df) -> df
c( rep("CTL",3), rep("MPTP", 3)) -> colnames(df)
df.fit <- lmFit(df, list3)  ## 数据与list进行匹配
df.matrix <- makeContrasts(CTL - MPTP, levels = list3)
fit <- contrasts.fit(df.fit, df.matrix)
fit <- eBayes(fit)
tempOutput <- topTable(fit,n = Inf, adjust = "fdr")
## 导出所有的差异结果
nrDEG = na.omit(tempOutput) ## 去掉数据中有NA的行或列
output <- nrDEG  
#write.csv(output, "all.limmaOut.csv")
## 我们使用|logFC| > 0.5，padj < 0.05（矫正后P值）
foldChange = 0.01
padj = 0.05
## 筛选出所有差异基因的结果
All_diffSig <- output[(output$adj.P.Val < padj & (output$logFC > foldChange | output$logFC < (-foldChange))),]
## 我们发现竟然没有差异基因，这是应该我这边的数据是随机的结果，如果你的数据有这样的问题，你需要在仔细检查一下哦。
## 我们为了下面的操作正常进行，我们选用的P值（未矫正）进行筛选。
#All_diffSig <- output[(output$P.Value < padj & (output$logFC>foldChange | output$logFC < (-foldChange))),]
#write.csv(All_diffSig, "all.diffsig.csv")  ##输出差异基因数据集
#upreguate
diffup <-  All_diffSig[(All_diffSig$adj.P.Val < padj & (All_diffSig$logFC > foldChange)),]
#write.csv(diffup, "diffup.csv")
#
diffdown <- All_diffSig[(All_diffSig$adj.P.Val < padj & (All_diffSig < -foldChange)),]
#write.csv(diffdown, "diffdown.csv")
## 导入R包
library(ggplot2)
library(ggrepel)
##  绘制火山图
## 进行分类别
logFC <- output$logFC
deg.padj <- output$adj.P.Val
data <- data.frame(logFC = logFC, padj = deg.padj)
data$group[(data$padj > 0.05 | data$padj == "NA") | (data$logFC < foldChange) & data$logFC > -foldChange] <- "Not"
data$group[(data$padj <= 0.05 & data$logFC > 0.01)] <-  "Up"
data$group[(data$padj <= 0.05 & data$logFC < -0.01)] <- "Down"
data$gene <- rownames(All_diffSig)

p0 <-ggplot(data=output,aes(logFC,padj,color = group))
#添加散点；
p1 <- p0+geom_point(size=1)

# 开始绘图
#pdf('volcano.pdf',width = 7,height = 6.5)  ## 输出文件
label = subset(output,P.Value <0.05 & abs(logFC) > 0.01)
label1 = rownames(label)

colnames(output)[1] = 'log2FC'
Significant=ifelse((output$adj.P.Val < 0.05 & abs(output$log2FC)> 0.01), ifelse(output$log2FC > 0.01,"Up","Down"), "Not")
p <- ggplot(output, aes(log2FC, -log10(P.Value)))+
  geom_point(aes(col=Significant))+
  scale_color_manual(values=c("#0072B5","#BC3C28","grey"))+
  labs(title = " ")+
  geom_vline(xintercept=c(-0.05,0.05), colour="black", linetype="dashed")+
  geom_hline(yintercept = -log10(0.05),colour="black", linetype="dashed")+
  theme(plot.title = element_text(size = 16, hjust = 0.5, face = "bold"))+
  labs(x="log2(FoldChange)",y="-log10(Pvalue)")+
  theme(axis.text=element_text(size=13),axis.title=element_text(size=13))+theme_bw()
#str(output, max.level = c(-1, 1))

#dev.off()

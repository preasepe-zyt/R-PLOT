## limma ??????????
## Author: С?ŵ????ŹPӛ

setwd("D:\С?ŵ????ŹPӛ")

## ??????
library(limma)
library(dplyr)
## ????????
df <- Counts_data
head(df)
### ??????Ϣע??
list <- c(rep("Treat", 66), rep("CK",148)) %>% factor(., levels = c("CK", "Treat"), ordered = F)
head(list)
list <- model.matrix(~factor(list)+0) 
colnames(list) <- c("CK", "Treat")
as.data.frame(df) -> df
df.fit <- lmFit(df, list)

##  ????????
df.matrix <- makeContrasts(CK - Treat, levels = list)
fit <- contrasts.fit(df.fit, df.matrix)
fit <- eBayes(fit)
tempOutput <- topTable(fit,n = Inf, adjust = "fdr")
head(tempOutput)

## 
nrDEG = na.omit(tempOutput) ## ȥ??????????NA???л???
diffsig <- nrDEG  
write.csv(diffsig, "all.limmaOut.csv")  


##  ɸѡ??????????
foldChange = 0.5
padj = 0.05
All_diffSig <- diffsig[(diffsig$P.Value < padj & (diffsig$logFC>foldChange | diffsig$logFC < (-foldChange))),]
dim(All_diffSig)
write.csv(All_diffSig, "all.diffsig.csv")  ##???????????????ݼ?


## ɸѡ?ϵ????µ??Ĳ???
diffup <-  All_diffSig[(All_diffSig$P.Value < padj & (All_diffSig$logFC > foldChange)),]
dim(diffup)
write.csv(diffup, "diffup.csv")
#
diffdown <- All_diffSig[(All_diffSig$P.Value < padj & (All_diffSig < -foldChange)),]
dim(diffdown)
write.csv(diffdown, "diffdown.csv")

#---------------------------------
# ???ƻ?ɽͼ
library(ggplot2)
library(ggrepel)
###
logFC <- diffsig$logFC
deg.padj <- diffsig$P.Value
data <- data.frame(logFC = logFC, padj = deg.padj)
data$group[(data$padj > 0.05 | data$padj == "NA") | (data$logFC < foldChange) & data$logFC > -foldChange] <- "Not"
data$group[(data$padj <= 0.05 & data$logFC > 1)] <-  "Up"
data$group[(data$padj <= 0.05 & data$logFC < -1)] <- "Down"
x_lim <- max(logFC,-logFC)
###
pdf('volcano.pdf',width = 7,height = 6.5)
label = subset(diffsig,P.Value <0.05 & abs(logFC) > 0.5)
label1 = rownames(label)

colnames(diffsig)[1] = 'log2FC'
Significant=ifelse((diffsig$P.Value < 0.05 & abs(diffsig$log2FC)> 0.5), ifelse(diffsig$log2FC > 0.5,"Up","Down"), "Not")

ggplot(diffsig, aes(log2FC, -log10(P.Value)))+
  geom_point(aes(col=Significant))+
  scale_color_manual(values=c("#0072B6","grey","#BC3C28"))+
  labs(title = " ")+
  geom_vline(xintercept=c(-0.5,0.5), colour="black", linetype="dashed")+
  geom_hline(yintercept = -log10(0.05),colour="black", linetype="dashed")+
  theme(plot.title = element_text(size = 16, hjust = 0.5, face = "bold"))+
  labs(x="log2(FoldChange)",y="-log10(Pvalue)")+
  theme(axis.text=element_text(size=13),axis.title=element_text(size=13))+
  str(diffsig, max.level = c(-1, 1))+theme_bw()

dev.off()

##  ???Ʋ?????????ͼ
library(pheatmap)

## ???½ڣ???????ֻʹ??countֵ??????ͼ???ƣ??????ķ????У????ǻ??????????Ż?
DEG_id <- read.csv("all.diffsig.csv", header = T)
head(DEG_id)
## ƥ??
DEG_id <- unique(DEG_id$X)
DEG_exp <- df[DEG_id,]
hmexp <- na.omit(DEG_exp)

## ????ע????Ϣ 
annotation_col <- data.frame(Group = factor(c(rep("Treat", 66), rep("CK",148))))
rownames(annotation_col) <- colnames(hmexp)

##  ??????ͼ 
pdf(file = "heatmap02.pdf", height = 8, width = 12)
p <- pheatmap(hmexp,
              annotation_col = annotation_col,
              color = colorRampPalette(c("blue","white","red"))(50),
              cluster_cols = F,
              show_rownames = F,
              show_colnames = F,
              scale = "row", ## none, row, column
              fontsize = 12,
              fontsize_row = 12,
              fontsize_col = 6,
              border = FALSE)
print(p)
dev.off()

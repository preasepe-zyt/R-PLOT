
#引用包
library(pROC)
library(extrafont)
library(tidyverse)
loadfonts(device = "pdf")
#导入字体进入pdf
#showtext包可给定字体文件，加载到 R环境中，生成新的字体家族名字，后期调用这个名字设定字体，并且支持中文写入pdf不乱码
library(showtext)
showtext_auto(enable=TRUE)
#train
ids_exprs %>% mutate(gene=rownames(ids_exprs)) -> data
data[intersect(data$gene,final_genes$x),] %>% select(c(1:22)) %>% t() -> train
cbind(group_list,train) %>% as.data.frame() -> train
write.csv(train,"train.txt")
train$group_list -> group_list

#ridge	
ridge <- data[intersect(data$gene,c("MMP9","ALOX5","C5AR1","VDR","HMGCR","MALT1","MAPK14","ALOX5AP")),] %>% select(c(1:22)) %>% t()
roc_ridge <- cbind(group_list,ppi) %>% as.data.frame()
ridge_model <- glm(group_list~ MMP9+ALOX5+C5AR1, roc_ridge,family = "binomial",control=list(maxit=100))

#lasso
lasso <- data[intersect(data$gene,c("ALOX5","VDR")),] %>% select(c(1:22)) %>% t() 
cbind(group_list,lasso) %>% as.data.frame() -> roc_lasso
lasso_model <- glm(group_list~ ALOX5+VDR, roc_lasso,family = "binomial",control=list(maxit=100))

#SVM_RFE
SVM_RFE <- data[intersect(data$gene,c("VDR","ALOX5","C5AR1","MMP9","MAPK14")),] %>% select(c(1:22)) %>% t() 
roc_SVM_RFE <- cbind(group_list,SVM_RFE) %>% as.data.frame() 
SVM_RFE_model <- glm(group_list~ ALOX5+C5AR1+MMP9+MAPK14 , roc_SVM_RFE,family = "binomial",control=list(maxit=100))

#randomforest
randomforest <- data[intersect(data$gene,c("VDR","ALOX5","C5AR1","HMGCR")),] %>% select(c(1:22)) %>% t() 
roc_randomforest <- cbind(group_list,randomforest) %>% as.data.frame() 
randomforest_model <- glm(group_list~ ALOX5+C5AR1+VDR+HMGCR, roc_randomforest,family = "binomial",control=list(maxit=100))

#GBM
GBM_ <- data[intersect(data$gene,GBM$var),] %>% select(c(1:22)) %>% t() 
roc_GBM <- cbind(group_list,GBM_) %>% as.data.frame()
colnames(roc_GBM)
GBM_model <- glm(group_list~ C5AR1+VDR+HMGCR+MMP9+MALT1+MAPK14+ALOX5AP,roc_GBM,family = "binomial",control=list(maxit=50))

#xboost
xboost <- data[intersect(data$gene,c("ALOX5","VDR")),] %>% select(c(1:22)) %>% t()
roc_xboost <- cbind(group_list,xboost) %>% as.data.frame() 
xboost_model <- glm(group_list~ ALOX5+VDR,roc_xboost,family = "binomial",control=list(maxit=100))

#ENET
ENET <- data[intersect(data$gene,c("VDR","ALOX5","C5AR1","MALT1","ALOX5AP")),] %>% select(c(1:22)) %>% t()
roc_ENET <- cbind(group_list,ENET) %>% as.data.frame() 
ENET_model <- glm(group_list~ ALOX5+C5AR1+ALOX5AP,roc_ENET,family = "binomial",control=list(maxit=100))

#PLS_DA	
PLS_DA	<- data[intersect(data$gene,c("VDR","ALOX5","C5AR1","MALT1","ALOX5AP","HMGCR","MAPK14")),] %>% select(c(1:22)) %>% t()
roc_PLS_DA <- cbind(group_list,PLS_DA) %>% as.data.frame() 
PLS_DA_model <- glm(group_list~ MALT1+ALOX5AP+HMGCR+MAPK14,roc_PLS_DA ,family = "binomial", control=list(maxit=100))



library(performance)
library(ggplot2)
pdf("ROC_组合.pdf",width = 8,height = 8,family="Arial")
output <- performance_roc(PLS_DA_model,ridge_model,lasso_model,SVM_RFE_model,randomforest_model,GBM_model,xboost_model,ENET_model)
ggplot(output,aes(x=Specificity, y=Sensitivity, fill=Model,color=Model))+
    geom_line(size=1)+
    labs(x="1 - Specificity (False Positive Rate)",y="Sensitivity (True Positive Rate)")+
    theme_classic()+
    mytheme+
    scale_color_discrete(labels = c("ENET_model: 95.83%",
                                    "GBM_model: 95.00%",
                                    "LASSO_model: 95.83%",
                                    "PLS_DA_model: 93.33%",
                                    "RANDOMFOREST_model: 97.50%",
                                    "RIDGE_model: 95.83%",
                                    "SVM_RFE_model: 96.67%",
                                    "XBOOST_model: 95.83%"
                                    ))

dev.off()
#box
case_when(roc_randomforest$group_list==0~"Control",
          roc_randomforest$group_list==1~"Depression") -> roc_randomforest$group_list
roc_randomforest %>% melt() -> box_randomforest
# 3.3 出图
if(T){mytheme <- theme(plot.title = element_text(size = 20,color="black",hjust = 0.5,family="Arial",face = "bold"),
                       axis.title = element_text(size = 20,color ="black", family="Arial",face = "bold"), 
                       axis.text = element_text(size= 20,color = "black", family="Arial",face = "bold"),
                       #panel.grid.minor.y = element_blank(),
                       #panel.grid.minor.x = element_blank(),
                       axis.text.x = element_text(hjust = 1,family="Arial",face = "bold" ),
                       legend.text = element_text(size= 20, family="Arial",face = "bold"),
                       legend.title= element_text(size= 20, family="Arial",face = "bold"),
                       axis.text.y = element_text(margin = margin(0,0,0,0.2,'cm')),
                       axis.ticks.length.y = unit(.25, "cm"),
                       #legend.justification=c(2,0),
                       legend.position=c(0.65,0.30),
                       #legend.spacing.y = unit(-100, 'cm')
                       #axis.ticks = element_line(linewidth = 2,size = 2)
) }


#引用包
library(pROC)


#导入初始数据：

inputFile="input.txt"      
outFile="ROC.pdf"         

#读取
rt=read.table(inputFile,header=T,sep="\t",check.names=F,row.names=1)
head(rt)
#转换成适合的数据框
ids_exprs[rownames(ids_exprs) %in% df1,] -> data
t(data) -> roc
data -> roc
ifelse(str_detect(roc$V4,"normal"),1,2) -> group_list
roc_randomforest -> roc

y=colnames(roc)[1]
#定义颜色
bioCol=c("#35A585","#CC78A6",'#0796E0',"#C71585")
if(ncol(roc)>4){
    bioCol=rainbow(ncol(roc))}

#绘制
pdf("roc曲线.pdf",width=6,height=6,family = "Arial")
roc1=roc(roc[,y], as.vector(roc[,2]))
aucText=c( paste0(colnames(roc)[2],", AUC=",sprintf("%0.3f",auc(roc1))) )
plot(roc1, col=bioCol[1],axis=3)
for(i in 3:ncol(roc)){
    roc1=roc(roc[,y], as.vector(roc[,i]))
    lines(roc1, col=bioCol[i-1])
    aucText=c(aucText, paste0(colnames(roc)[i],", AUC=",sprintf("%0.3f",auc(roc1))) )
}
legend("bottomright", aucText,lwd=2,bty="n",col=bioCol[1:(ncol(roc)-1)])
dev.off()





library(ggplot2)
library(ggpubr)
pdf("box_验证.pdf",width = 6,height = 6,family="Arial")
ggplot(box_randomforest, aes(x = variable, y = value))+ 
    labs(y="Expression",x= NULL,title = "GSE76826",caption ="")+  
    geom_boxplot(aes(fill = group_list),position=position_dodge(0.5),width=0.5,outlier.alpha = 0)+ 
    scale_fill_manual(values = c("#1CB4B8", "#EB7369"))+
    theme_classic() + mytheme + 
    stat_compare_means(aes(group = group_list),
                       label = "p.signif",
                       method = "wilcox.test",
                       hide.ns = F,
                       label.y = c(7.9,5,3.2,3.4),
                       size=10)
dev.off()


if(T){roctheme <- theme(plot.title = element_text(size = 20,color="black",hjust = 0.5,family="Arial",face = "bold"),
                       axis.title = element_text(size = 20,color ="black", family="Arial",face = "bold"), 
                       axis.text = element_text(size= 20,color = "black", family="Arial",face = "bold"),
                       #panel.grid.minor.y = element_blank(),
                       #panel.grid.minor.x = element_blank(),
                       axis.text.x = element_text(hjust = 1,family="Arial",face = "bold" ),
                       #panel.grid=element_blank(),
                       legend.position = "right",
                       legend.text = element_text(size= 20, family="Arial",face = "bold"),
                       legend.title= element_text(size= 20, family="Arial",face = "bold"),
                       axis.text.y = element_text(margin = margin(0,0,0,0.2,'cm')),
                       axis.ticks.length.y = unit(.25, "cm")
                       #axis.ticks = element_line(linewidth = 2,size = 2)
) }



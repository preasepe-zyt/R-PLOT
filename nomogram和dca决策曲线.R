library(survival)
library(survminer)
library(rms)
library(rmda)
library(ggDCA)
library(ggplot2)
library(caret)
as.data.frame(data3) -> data3
ddist <- datadist(as.data.frame(data3))
options(datadist='ddist')
f <- lrm(group_list ~ APP + CHRM1  + CCKBR, data=data3) 
summary(f)   ##也能用此函数看具体模型情况，模型的系数，置信区间等
###  nomogram
par(mgp=c(1.6,0.6,0),mar=c(2,2,2,2))  ## 设置画布
nomogram <- nomogram(f,fun=function(x)1/(1+exp(-x)), ##逻辑回归计算公式
                     fun.at = c(0.001,0.01,0.05,seq(0.1,0.9,by=0.1),0.95,0.99,0.999),#风险轴刻度
                     funlabel = "Risk of AD", #风险轴便签
                     lp=F,  ##是否显示系数轴
                     conf.int = F, ##每个得分的置信度区间，用横线表示，横线越长置信度越
                     abbrev = F#是否用简称代表因子变量
)
plot(nomogram)
#dca决策曲线
dca_lrm <- dca(f ,model.names = "Nomogram")
ggplot(dca_lrm, lwd = 0.5)

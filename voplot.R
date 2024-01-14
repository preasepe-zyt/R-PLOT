library(ggplot2)#绘图包
library(ggpubr)#基于ggplot2的可视化包，主要用于绘制符合出版要求的图形
library(ggsignif)#用于P值计算和显著性标记
library(tidyverse)#数据预处理
library(ggprism)#提供了GraphPad prism风格的主题和颜色，主要用于美化我们的图形
library(vioplot)#小提琴图绘制包
vioplot(sex, age, col=c("skyblue", "plum"), rectCol=c("lightblue", "palevioletred"), lineCol="blue", border=c("royalblue", "purple"), names=c("sex", "age"),main="context", xlab="data class", ylab="data read")
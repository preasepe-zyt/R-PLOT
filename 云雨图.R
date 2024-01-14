library(ggplot2)
library(gghalves)
library(ggpubr)
library(ggsignif)
library(ggplot2)
library(readxl)
X2 <- read_excel("C:/Users/79403/Desktop/2.xlsx")
zoo::na.spline(X2) -> X2
#na.omit()
colnames(X2) -> name1
as.matrix(X2) -> X2
dim(X2) <- c(21,1)
name1 <- c(rep("CTL",3),rep("AlCl3",3),rep("AlCl3+Donepezil",3),rep("AlCl3+4 μg/mL",3),rep("AlCl3+8 μg/mL",3),rep( "AlCl3+16 μg/mL",3),rep(  "16 μg/mL alone",3))
name2 <- c("len","group")
X2 <- data.frame(X2,name1)
colnames(X2) <- name2
X2$group <- factor(X2$group,levels=c("CTL","AlCl3","AlCl3+Donepezil","AlCl3+4 μg/mL","AlCl3+8 μg/mL","AlCl3+16 μg/mL","16 μg/mL alone"))
mycolor<-c("#9DCD82","#F8B62D","#F2997A","#CE97B0","#F4A9A8","#CE97B0","#F4A9A8") 
n <-ggplot(X2,aes(x=group,
                   y=len,
                   fill=group,
                   color=group))

n0 <-n+scale_color_manual(values=rev(mycolor))+scale_fill_manual(values=rev(mycolor))
n1<- n0+geom_half_violin()
n2 <-n0+geom_half_violin(position=position_nudge(x=0.1,y=0),
                        side='R',adjust=2,trim=F,color=NA,alpha=0.8,linewidth=10)
n2

n4 <- n2+geom_point(aes(x = group,y = len,color = group),position = position_jitter(width =0.03),size =2, shape = 20)
n4
#n4<- n2+geom_point(aes(x = as.numeric(Species)-0.1,y = len,color = group),position = position_jitter(width =0.03),size =0.2, shape = 20)
n5<- n4+geom_boxplot(outlier.shape = NA, #隐藏离群点；
                    width =0.1,
                    alpha=0.1)
n5
n6 <- n5+theme_bw()+theme(panel.grid=element_blank())
my_comparisons <- list( c("CTL", "MPTP"), c("MPTP", "CTL", "MPTP"), c("MPTP", "50ug"),c("MPTP", "100ug") )
n7 <- n6+stat_compare_means(method = "t.test", label = "p.signif",comparisons = my_comparisons)
n8 <- n7 + xlab("group") + ylab("totaldistance")

n10 <- n6 +geom_signif(annotations = c("***", "###","###","#")
                ,y_position = c(150, 200, 250, 300)
                ,xmin = c(1, 2, 2, 2)
                ,xmax = c(2, 3, 4, 5)
                #,tip_length = c(0.05,0.4,0.05,0.2,0.05,0.01)
                ,color="black")
n11 <- n10 + xlab("group") + ylab("totaldistance")
n12 <- n11 + labs(title = "Total:min22")+ theme(plot.title = element_text(family = "serif", #字体
                                                                         #face = "bold",     #字体加粗
                                                                         #color = "red",      #字体颜色
                                                                         size = 15,          #字体大小
                                                                         hjust = 0.5,          #字体左右的位置
                                                                         vjust = -10,          #字体上下的高度
                                                                         #angle = 0,          #字体倾斜的角度
))


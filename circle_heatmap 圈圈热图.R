library('ComplexHeatmap')
library('circlize')
library(tidyverse)
data <- data.frame(value=rnorm(100,sd=5,mean=10),
                   value=rnorm(100,sd=5,mean=10),
                   value=rnorm(100,sd=5,mean=10),
                   value=rnorm(100,sd=5,mean=10),
                   value=rnorm(100,sd=5,mean=10))
rnames <- c(length=100)
i <- 0
while (i < 100){
    i = i +1
    rnames[i] <- paste(sample(letters, 4), collapse="")
    print(rnames[i])
    }
    
rownames(data) <- rnames
madt<-as.matrix(data)
madt2<-t(scale(t(madt)))

#计算数据大小范围
range(madt2)
#重新定义热图颜色梯度：
mycol=colorRamp2(c(-1.7, 0.3, 2.3),c("#57ab81", "white", "#ff9600"))

#在circos.heatmap()中添加参数进行环形热图的调整和美化：
circos.par(gap.after=c(20))
circos.heatmap(madt2,col=mycol,dend.side="inside",rownames.side="outside",
               rownames.col="black",
               rownames.cex=0.5,
               rownames.font=1,
               cluster=TRUE)
circos.clear()
#circos.par()调整圆环首尾间的距离，数值越大，距离越宽
#dend.side：控制行聚类树的方向，inside为显示在圆环内圈，outside为显示在圆环外圈
#rownames.side：控制矩阵行名的方向,与dend.side相同；但注意二者不能在同一侧，必须一内一外
#cluster=TRUE为对行聚类，cluster=FALSE则不显示聚类

#聚类树的调整和美化(需要用到两个别的包）：
library(dendextend)
library(dendsort)
circos.par(gap.after=c(50))
circos.heatmap(madt2,col=mycol,rownames.side="outside",
               track.height = 0.38,
               rownames.col="black",
               rownames.cex=0.7,
               cluster=F,
               rownames.font = 2,
               dend.track.height=0.18,
               dend.callback=function(dend,m,si) {
                   color_branches(dend,k=15,col=1:15)
               }
)

#track.height：轨道的高度，数值越大圆环越粗
#dend.track.height：调整行聚类树的高度
#dend.callback：用于聚类树的回调，当需要对聚类树进行重新排序，或者添加颜色时使用
#包含的三个参数：dend：当前扇区的树状图；m：当前扇区对应的子矩阵；si：当前扇区的名称
#color_branches():修改聚类树颜色

#添加图例标签等
library(gridBase)
lg_Exp1=Legend(title="Exp",col_fun=mycol,direction = c("vertical"))
#"horizontal"

#lg_Exp2=Legend(title="Exp2",col_fun=mycol,direction = c("vertical"))
circle_size = unit(0.07, "snpc")
h = dev.size()
lgd_list = packLegend(lg_Exp1, max_height = unit(2*h, "inch"))
draw(lgd_list, x = circle_size, just = "center")
draw(lg_Exp1)


#添加列名：
circos.track(track.index=get.current.track.index(),panel.fun=function(x,y){
    if(CELL_META$sector.numeric.index==1){
        cn=colnames(madt2)
        n=length(cn)
        circos.text(rep(CELL_META$cell.xlim[2],n)+convert_x(0,"mm"),#x坐标
                    -0.2+(1:n)*1.1,#y坐标
                    cn,cex=0.8,adj=c(0,1),facing="inside",font=2)
    }
},bg.border=NA)
circos.clear()












#多轨热图绘制：
#假设有两个热图的矩阵数据（这里仅为一组重复两次以作示范）
madt2<-t(scale(t(madt)))
madt3<-t(scale(t(madt)))
split2 = sample(letters[1:2], 40, replace = TRUE)
split2 = factor(split2, levels = letters[1:2])
circos.par(gap.after=c(8))
circos.heatmap(madt2,col=mycol2,split=split2,dend.side="outside",
               cluster=TRUE,
               dend.track.height=0.2,
               dend.callback=function(dend,m,si) {
                   color_branches(dend,k=15,col=1:15)
               }
)
circos.heatmap(madt3, col = mycol,rownames.side="inside",rownames.cex=0.8)#加入第二个热图
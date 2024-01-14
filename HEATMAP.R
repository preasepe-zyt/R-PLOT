library(pheatmap) # 加载pheatmap这个R包

# 1，读取热图数据文件
df = read.delim("https://www.bioladder.cn/shiny/zyp/demoData/heatmap/data.heatmap.txt", #文件名称 注意文件路径，格式
                header = T, # 是否有标题
                sep = "\t", # 分隔符是Tab键
                row.names = 1, # 指定第一列是行名
                fill=T) # 是否自动填充，一般选择是

#标记
library(pheatmap)
library(ggsci)
library(tidyverse)
Type=c(rep("Control",3),rep("MPTP",3),rep("RP",3))
names(Type)=colnames(final_q)
Type=as.data.frame(Type)
#分组标签的注释颜色
anncolor=list(Type=c(Control=pal_npg()(1),MPTP=pal_npg()(2)[2],RP=pal_npg()(3)[3]))

# 2，绘图
library(circlize)
col_fun <- colorRamp2(c(-0.5,0,0.5),c("#04a3ff","#ffffff","#ff349c"))
ht <- function(x){pheatmap(x, 
         # annotation_row=dfGene, # （可选）指定行分组文件
         # annotation_col=dfSample, # （可选）指定列分组文件
         show_colnames = TRUE, # 是否显示列名
         show_rownames=TRUE,  # 是否显示行名
         fontsize=10, # 字体大小 
         color = colorRampPalette(c("#386CB0","#F7FCF0","#E64B35CC"))(50),# 指定热图的颜色
         #color = colorRampPalette(c("#04a3ff","#ffffff","#ff349c"))(50),
         annotation_legend = TRUE, # 是否显示图例
         border_color= NA,# 边框颜色 NA表示没有
         scale = "row", 
         annotation_colors=anncolor,
         annotation=Type,
         #scale = "column",  # 指定归一化的方式。"row"按行归一化，"column"按列归一化，"none"不处理
         #cluster_rows = TRUE, # 是否对行聚类
         cluster_cols = F, # 是否对列聚类
         #display_numbers = TRUE,
         angle_col = 45
      )} 



# 2，绘图
data(mtcars)
M = cor(n)
set.seed(0)
wb = c('white', 'black')
library(corrplot)
corrplot(ran2, is.corr = FALSE, col.lim = c(100, 300), col = COL1(, 100))
par(ask = TRUE)
corrplot(M, method = 'number', col = 'black', cl.pos = 'n')

corrplot(M)
corrplot(M, order = 'AOE')
corrplot(M, order = 'AOE', addCoef.col = 'grey')

corrplot(M, order = 'AOE',  cl.length = 21, addCoef.col = 'grey')
corrplot(M, order = 'AOE', col = COL2(n=10), addCoef.col = 'grey')

corrplot(M, order = 'AOE', col = COL2('PiYG'))
corrplot(M, order = 'AOE', col = COL2('PRGn'), addCoef.col = 'grey')
corrplot(M, order = 'AOE', col = COL2('PuOr', 20), cl.length = 21, addCoef.col = 'grey')
corrplot(M, order = 'AOE', col = COL2('PuOr', 10), addCoef.col = 'grey')

corrplot(M, order = 'AOE', col = COL2('RdYlBu', 100))
corrplot(M, order = 'AOE', col = COL2('RdYlBu', 10))


corrplot(c, method = 'color', col = COL2(n=20), cl.length = 21, order = 'AOE',
         addCoef.col = 'white')
corrplot(M, method = 'square', col = COL2(n=200), order = 'AOE')
corrplot(M, method = 'ellipse', col = COL2(n=200), order = 'AOE')
corrplot(M, method = 'shade', col = COL2(n=20), order = 'AOE')
corrplot(M, method = 'pie', order = 'AOE')

## col = wb
corrplot(c, col = wb, order = 'AOE', outline = TRUE, cl.pos = 'n')

## like Chinese wiqi, suit for either on screen or white-black print.
corrplot(M, col = wb, bg = 'gold2',  order = 'AOE', cl.pos = 'n')


## mixed methods: It's more efficient if using function 'corrplot.mixed'
## circle + ellipse
corrplot(M, order = 'AOE', type = 'upper', tl.pos = 'd')
corrplot(M, add = TRUE, type = 'lower', method = 'ellipse', order = 'AOE',
         diag = FALSE, tl.pos = 'n', cl.pos = 'n')

## circle + square
corrplot(M, order = 'AOE', type = 'upper', tl.pos = 'd')
corrplot(M, add = TRUE, type = 'lower', method = 'square', order = 'AOE',
         diag = FALSE, tl.pos = 'n', cl.pos = 'n')

## circle + colorful number

corrplot(M, add = TRUE, type = 'lower', method = 'number', order = 'AOE',
         diag = FALSE, tl.pos = 'n', cl.pos = 'n')

## circle + black number
corrplot(M, order = 'AOE', type = 'upper', tl.pos = 'tp')
corrplot(M, add = TRUE, type = 'lower', method = 'number', order = 'AOE',
         col = 'black', diag = FALSE, tl.pos = 'n', cl.pos = 'n')


## order is hclust and draw rectangles
corrplot(M, order = 'hclust')
corrplot(M, order = 'hclust', addrect = 2)
corrplot(M, order = 'hclust', addrect = 3, rect.col = 'red')
corrplot(M, order = 'hclust', addrect = 4, rect.col = 'blue')
corrplot(M, order = 'hclust', hclust.method = 'ward.D2', addrect = 4)
corrplot(M, method = 'pie', order = 'AOE')
library(ComplexHeatmap) 
library(circlize) 
library(RColorBrewer)
#提前标准化数据
heatmapdata <- testdata1 
heatmapdata <- t(scale(t(heatmapdata))) 
#heatmapdata[heatmapdata>2]=2 
#heatmapdata[heatmapdata<-2]=-2 
Heatmap(testdata1)
Heatmap(heatmapdata)
col_fun = colorRamp2(c(-2, 0, 2), c("green", "white", "red"))
Heatmap(heatmapdata, name=" ", col=col_fun)
Heatmap(heatmapdata, name=" ", col=rev(rainbow(10)))
Heatmap(heatmapdata, name=" ", col=col_fun,border=TRUE,rect_gp=gpar(col="white",lwd=2))
Heatmap(heatmapdata, name=" ", 
          +         split = anno_row$chromosome,
          +         column_split = anno_col$Group)
Heatmap(heatmapdata, name=" ", 
          +         split = anno_row$chromosome,
          +         column_split = anno_col$Group,
          +         column_title = NULL,
          +         row_title_gp = gpar(col="white",fontsize=11,
                                        +                             fill=brewer.pal(8,"Set1")[1:5]))
Heatmap(heatmapdata, name=" ",
        +         heatmap_legend_param = list(legend_height=unit(6,"cm"),
                                              +                                     grid_width=unit(0.8,"cm")))


library(heatmaply)
heatmaply(iris[, -5], k_row = 3, k_col = 2)
heatmaply(cor(iris[, -5]))

heatmaply(cor(iris[, -5]), limits = c(-1, 1))
heatmaply(mtcars, k_row = 3, k_col = 2)
# heatmaply(mtcars, k_row = 3, k_col = 2, grid_color = "white")
heatmaply(mtcars, k_row = 3, k_col = 2, grid_gap = 1)



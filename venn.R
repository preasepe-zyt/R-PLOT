install.packages("VennDiagram")
library(VennDiagram)
############### Venn图 ####################
# 产生3组数据集
set1 <- paste(rep("word_" , 200) , sample(c(1:1000) , 200 , replace=F) , sep="")
set2 <- paste(rep("word_" , 200) , sample(c(1:1000) , 200 , replace=F) , sep="")
set3 <- paste(rep("word_" , 200) , sample(c(1:1000) , 200 , replace=F) , sep="")

# 绘图：
# 直接保存：
venn.diagram(
  x,
  category.names = c("Set 1" , "Set 2 "),
  filename = 'venn_plot1.png',
  output=TRUE
)

# 展示后保存：
# pdf("plot1.pdf")
p1 <- venn.diagram(
  x = list(set1, set2, set3),
  category.names = c("Set 1" , "Set 2 " , "Set 3"),
  filename = NULL,
  # output=TRUE
)

# 展示图片：
grid.newpage();
grid.draw(p1);

# dev.off()
###### 填色和修改描边：######
# 使用RColorBrewer：使用一种模板中的3种颜色：
library(RColorBrewer)
myCol <- brewer.pal(3, "Pastel2")

# Chart
venn.diagram(
  x = list(set1, set2, set3),
  category.names = c("Set 1" , "Set 2 " , "Set 3"),
  filename = 'xxxx.png',
  output=TRUE,
  
  # 设置输出：
  imagetype="png" ,
  height = 1000 , 
  width = 1000 , 
  resolution = 300,
  compression = "lzw",
  
  # 圆的调整：
  lwd = 2, # 描边粗细
  lty = "blank",  # 去掉描边
  fill = myCol,  # 填充颜色
  
  # 文字大小：
  cex = .5,  # 大小；
  fontface = "bold",  # 粗体
  fontfamily = "sans",  # 字体
  
  # 每个集合的名称：
  cat.cex = 0.6,
  cat.fontface = "bold",
  cat.default.pos = "outer",  # 集合名称位置：outer -- 外部；text -- 内部
  cat.pos = c(-27, 27, 180),  # 集合名称分别在圈圈的什么角度
  cat.dist = c(0.055, 0.055, 0.055),  # 外部多少距离
  cat.fontfamily = "sans",
  rotation = 1  # 旋转
)
###### 四维、五维韦恩图 ######
set4 <- paste(rep("word_" , 200) , sample(c(1:1000) , 200 , replace=F) , sep="")
set5 <- paste(rep("word_" , 200) , sample(c(1:1000) , 200 , replace=F) , sep="")

# 四维韦恩图
venn.diagram(
  x = list(set1,set2,set3,set4),
  category.names = c("Set 1" , "Set 2 " , "Set 3", "Set 4"),
  filename = "venn_plot3.png",
  
  # 设置输出：
  imagetype="png" ,
  height = 1000 , 
  width = 1000 , 
  resolution = 300,
  compression = "lzw",
  
  # 圆圈属性：
  col = "white",  # 描边颜色
  lty = 1, # 虚线形式:1,2,3,4,5可选
  lwd = 1,  # 粗细
  fill = c("#ffd7d8", "#d8f2e7", "#d9e7f2", "#eadff0"),  # 填充颜色；
  alpha = 0.90, # 透明度
  
  # 标签属性：
  label.col = "black",
  # c("#ffd7d8", "black", "#d8f2e7", "black", "black", "black",
  #            "black", "black", "#d9e7f2", "black",
  #            "black", "black", "black", "#eadff0", "black"),
  cex = .5, # 字体大小
  fontfamily = "serif",
  fontface = "bold",
  
  # 集合名称属性：
  cat.col = c("#cb6274", "#7ba498", "#687d94", "#81668b"),
  cat.cex = .6,
  cat.fontfamily = "serif"
)


# 五维韦恩图
venn.diagram(
  x = list(set1,set2,set3,set4,set5),
  category.names = c("Set 1" , "Set 2 " , "Set 3", "Set 4", "Set 5"),
  filename = "venn_plot4.png",
  
  # 设置输出：
  imagetype="png" ,
  height = 1000 , 
  width = 1000 , 
  resolution = 300,
  compression = "lzw",
  
  # 圆圈属性：
  col = "white",  # 描边颜色
  lty = 1, # 虚线形式:1,2,3,4,5可选
  lwd = 1,  # 粗细
  fill = c("#ffd7d8", "#d8f2e7", "#d9e7f2", "#eadff0", "#fff2cd"),  # 填充颜色；
  alpha = 0.90, # 透明度
  
  # 标签属性：
  label.col = "black",
  # c("#ffd7d8", "black", "#d8f2e7", "black", "black", "black",
  #            "black", "black", "#d9e7f2", "black",
  #            "black", "black", "black", "#eadff0", "black"),
  cex = .5, # 字体大小
  fontfamily = "serif",
  fontface = "bold",
  
  # 集合名称属性：
  cat.col = c("#cb6274", "#7ba498", "#687d94", "#81668b", "#ffcf5c"),
  cat.cex = .6,
  cat.fontfamily = "serif",
  cat.pos = c(0,-30,-130, 130, 40),
  cat.dist = 0.18  # 外部多少距离
)


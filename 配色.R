https://mp.weixin.qq.com/s/Y8pLTxGmvWkms3ssflgNIQ#配色
library(ggsci)
#使用Nature配色(NPG)
p2<-p+scale_color_npg()+scale_fill_npg()
#使用柳叶刀配色(Lancet)
p5<-p+scale_color_lancet()+scale_fill_lancet()
#使用Science配色(AAAS)
p3<-p+scale_color_aaas()+scale_fill_aaas()
#使用Journal of Clinical Oncology配色(JCO)
p6<-p+scale_color_jco()+scale_fill_jco()

#RColorBrewer包的安装和载入
install.packages('RColorBrewer')
library(RColorBrewer)
#作者将上述配色方案分为了三类（从上至下）：连续型(sequential)、离散型(Qualitative)、极端型(Diverging),可适用于不同类型的分类变量（非常方便！），以下代码可分别进行查看
display.brewer.all(type="seq")
display.brewer.all(type="qual")
display.brewer.all(type="div")

#使用Spectral配色方案
mycolor2<-brewer.pal(11, "Spectral")#可选择的颜色数量区间在此配色最大数和绘图所需数之间
p7<-p+scale_fill_manual(values=rev(mycolor2))+
  scale_color_manual(values=rev(mycolor2))
p7
#使用YlOrRd配色方案
mycolor3<-brewer.pal(9, "YlOrRd")
p8<-p+scale_fill_manual(values=rev(mycolor3))+
  scale_color_manual(values=rev(mycolor3))
p8
#提取所需配色的十六进制颜色
brewer.pal(9,"YlOrRd")
show_col(mycolor3)
#这个函数的基本用法：基于指定的颜色向量，生成指定数量的渐变颜色
col3<-colorRampPalette(c('blue','white','red'))(30)
show_col(col3)
#使用colorRampPalette()扩展R包配色方案中的颜色
col4<-colorRampPalette(brewer.pal(8,'Set2'))(56)#将RColorBrewer包中的Set2方案8个颜色扩展为56个
col5<-colorRampPalette((pal_npg("nrc")(9)))(56)#将ggsci包中的NPG方案9个颜色扩展为56个
show_col(col4)
show_col(col5)

#paletteer包的安装、调用、查看帮助文档
install.packages("paletteer")
library(paletteer)
?paletteer
#引号处配色名称可直接Tab键浏览选取，也可以直接输入，格式为：R包名称::配色方案名称
paletteer_c("gameofthrones::targaryen", n = 40)
paletteer_c("gameofthrones::arya", n = 15)
paletteer_c("pals::ocean.matter", n = 25)

点点快速获取颜色）。

#colorpicker包的安装、调用
install.packages("colourpicker")
library(colourpicker)

col_colourpicker<-#先设置需要赋值的颜色名，鼠标选择在Addins处选择colourpicker
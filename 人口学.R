library(ggplot2)
library(dplyr)
library(grid)
library(showtext)
library(Cairo)
library(ggpubr)
新建_Microsoft_Excel_工作表 <- read_excel("C:/Users/79403/Desktop/新建 Microsoft Excel 工作表.xlsx")
新建_Microsoft_Excel_工作表 -> p
colnames(p) <- c("no","class","nu","percent")
c("男","女","大一","大二","大三","大四","研究生以上","溺爱型", "民主型","专制型","放任型","担任过学生干部","未担任学生干部","很差","中等","较好","很好","获得过奖学金","未曾获得过奖学金","独生子女", "非独生子女","较贫困","一般","较富裕", "人际关系较差","人际关系一般","人际关系很好","农村", "小城镇", "中小城市","大城市","单亲家庭","非单亲家庭") -> na
rev(na) -> na

as.factor(p$class) -> p$class
p$class <- factor(p$class,levels =c("男","女","大一","大二","大三","大四","研究生以上","溺爱型", "民主型","专制型","放任型","担任过学生干部","未担任学生干部","很差","中等","较好","很好","获得过奖学金","未曾获得过奖学金","独生子女", "非独生子女","较贫困","一般","较富裕", "人际关系较差","人际关系一般","人际关系很好","农村", "小城镇", "中小城市","大城市","单亲家庭","非单亲家庭"))
p$class <- factor(p$class,levels = na)
ggplot(data=p)+geom_bar(aes(x=class, y=nu, fill=class), stat='identity')+coord_flip()+xlab("") + ylab("人数")+labs(title = "人口统计学结果")+theme(plot.title = element_text(hjust = 0.5))  -> p1
p1+geom_text(aes(class,nu,label=nu,hjust = 0, nudge_x = 0.05,color = class), show.legend = TRUE) -> p2
p2+theme(legend.title=element_blank())

1. ggplot2中添加title函数
1
2
3
4
ggtitle(label) # for the main title，主题目
xlab(label) # for the x axis label， xlab
ylab(label) # for the y axis label， ylab
labs(...) # for the main title, axis labels and legend titles，可以同时设定多个lab和tittle

2. 实际应用

（1）添加title、xlab和ylab
1
2
3
4
5
6
7
8
9
10
ToothGrowth$dose <- as.factor(ToothGrowth$dose)
library(ggplot2)
p <- ggplot(ToothGrowth, aes(x=dose, y=len)) + geom_boxplot()
## 方法1：
p + ggtitle("Plot of length \n by dose") +
  xlab("Dose (mg)") + ylab("Teeth length")

## 方法2：
p +labs(title="Plot of length \n by dose",
        x ="Dose (mg)", y = "Teeth length")

（2）修改legend名字
1
2
3
4
5
6
# Default plot
p <- ggplot(ToothGrowth, aes(x=dose, y=len, fill=dose))+
  geom_boxplot()
p
# Modify legend titles
p + labs(fill = "Dose (mg)")

（3）修改title的字体，位置，颜色等
参数，其中hjust和vjust可以调节位置， anglexlab和ylab调节角度，size可以调节label大小：

1
2
3
4
5
6
7
8
9
family : font family
face : font face. Possible values are “plain”, “italic”, “bold” and “bold.italic”
colour : text color
size : text size in pts
hjust : horizontal justification (in [0, 1])
vjust : vertical justification (in [0, 1])
lineheight : line height. In multi-line text, the lineheight argument is used to change the spacing between lines.
color : an alias for colour
angle: angle
使用：

1
2
3
4
5
6
7
8
9
10
11
12
# Default plot
p <- ggplot(ToothGrowth, aes(x=dose, y=len)) + geom_boxplot() +
  ggtitle("Plot of length \n by dose") +
  xlab("Dose (mg)") + ylab("Teeth length")
p
# Change the color, the size and the face of
# the main title, x and y axis labels
p + theme(
  plot.title = element_text(color="red", size=14, face="bold.italic"),
  axis.title.x = element_text(color="blue", size=14, face="bold"),
  axis.title.y = element_text(color="#993333", size=14, face="bold")
)
此外，修改坐标轴的angle也是相似的构造：

1
2
3
require(ggplot2)
ggplot(data=mtcars, aes(x=mpg, y=wt)) + geom_point()  + theme(axis.text.x = element_text(angle=90))
ggplot(data=mtcars, aes(x=mpg, y=wt)) + geom_point()  + theme(axis.text.y = element_text(angle=90))

（4）删除xlab和ylab
1
2
3
4
5
# Hide the main title and axis titles
p + theme(
  plot.title = element_blank(),
  axis.title.x = element_blank(),
  axis.title.y = element_blank())
# Hide the main title and axis titles
p + theme(
  plot.title = element_blank(),
  axis.title.x = element_blank(),
  axis.title.y = element_blank())

总之，一次性设定ggplot相关title的话， labs(title=" ", x=" ",y=" ")即可，修改需要使用后面的theme(axis.text.x = element_text(angle=90))，类似这种设定。

翻译来源：

http://www.sthda.com/english/wiki/ggplot2-title-main-axis-and-legend-titles


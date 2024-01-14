library(ggplot2)
library(ggpubr)
library(ggstatsplot)
library(ggsci)


pdf("Inflammatory_GSVA_SCORE.pdf",height=9,width=6,family = "serif")
ggplot(final_gsva_mat,aes(x=group2,
                          y=inflammation,
                          fill=group2)) + 
    geom_violin() + 
    geom_boxplot(width = 0.2) +
    scale_fill_jco() + 
    geom_jitter(shape = 16, size = 2, position = position_jitter(0.2)) +
    guides(fill = FALSE) + 
    theme_classic() +
    stat_compare_means(aes(group =  group2),
                       label = "p.signif",
                       method = "wilcox.test",
                       hide.ns = T,
                       label.y = 0.5,
                       label.x = 1.45,
                       size=10)+
    geom_signif(
        comparisons = list(c("Control", "Major Depressive Disorder")),  # 替换为你实际的组合
        y_position = 0.35,
        textsize = 0,
        size =  1# 调整横线的位置
        
    )+
    scale_y_continuous(limits = c(-1,1),expand = c(0,0))+
    labs(y="Inflammatory GSVA SCORE", x="",title = "") +
    mytheme 
dev.off()

if(T){mytheme <- theme(text = element_text(family = "serif"),
                       plot.title = element_text(size = 30,color="black",hjust = 0.5),
                       axis.title = element_text(size = 30,color ="black"), 
                       axis.text = element_text(size= 30,color = "black"),
                       #panel.grid.minor.y = element_blank(),
                       #panel.grid.minor.x = element_blank(),
                       axis.text.x = element_text(angle = 45,hjust = 1),
                       #panel.grid=element_blank(),
                       legend.position = "right",
                       legend.text = element_text(size= 20),
                       legend.title= element_text(size= 20),
                       axis.text.y = element_text(margin = margin(0,0,0,0.2,'cm')),
                       axis.ticks.length.y = unit(.25, "cm"),
                       #axis.ticks = element_line(linewidth = 2,size = 2)
) }


if (!require(ggplot2)) install.packages("ggplot2")
if (!require(ggpubr)) install.packages("ggpubr")
if (!require(ggstatsplot)) install.packages("ggstatsplot")
library(ggplot2)
library(ggpubr)
library(ggstatsplot)
数据读取
我们使用两套数据集，包括 mpg 和 iris，例子中大家稍微注意下，主要时因为分组的不同，需要选了不同的数据集。数据读取如下：

data(mpg)
mpg$year <- as.factor(mpg$year)
head(mpg)
## # A tibble: 6 x 11
##   manufacturer model displ year    cyl trans      drv     cty   hwy fl    class 
##   <chr>        <chr> <dbl> <fct> <int> <chr>      <chr> <int> <int> <chr> <chr> 
## 1 audi         a4      1.8 1999      4 auto(l5)   f        18    29 p     compa~
## 2 audi         a4      1.8 1999      4 manual(m5) f        21    29 p     compa~
## 3 audi         a4      2   2008      4 manual(m6) f        20    31 p     compa~
## 4 audi         a4      2   2008      4 auto(av)   f        21    30 p     compa~
## 5 audi         a4      2.8 1999      6 auto(l5)   f        16    26 p     compa~
## 6 audi         a4      2.8 1999      6 manual(m5) f        18    26 p     compa~
table(mpg$year)
## 
## 1999 2008 
##  117  117
data("iris")
head(iris)
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
table(iris$Species)
## 
##     setosa versicolor  virginica 
##         50         50         50
绘制小提琴图
小提琴图的绘制从简单到复杂，逐步增加难道，更加系统的学些绘图。

图片

1. 简单小提琴图
直接读取数据，加上 geom_violin() 就可以绘制出来小提琴图，非常简单！

ggplot(mpg, aes(x = class, y = hwy)) + geom_violin() + theme_bw()
图片

2. 水平小提琴图
旋转极坐标轴 coord_flip()， 实现水平旋转，如下：

ggplot(mpg, aes(x = class, y = hwy)) + geom_violin() + coord_flip() + theme_bw()
图片

3. 不修剪小提琴的尾部
我们也可以考虑保留小提琴的尾部 trim = FALSE，如下：

ggplot(mpg, aes(x = class, y = hwy)) + geom_violin(trim = FALSE) + theme_bw()
图片

4. 添加统计值
使用stat_summary()添加统计量 mean，使用point显示均值的位置，如下：

ggplot(mpg, aes(x = class, y = hwy)) + geom_violin(trim = FALSE) + stat_summary(fun = mean,
                                                                                geom = "point", shape = 23, size = 2, color = "blue") + theme_bw()
图片

5. 加均值及标准差
使用stat_summary()添加均值和标准差，如下：

ggplot(mpg, aes(x = class, y = hwy)) + geom_violin(trim = FALSE) + stat_summary(fun.data = "mean_sdl",
                                                                                fun.args = list(mult = 1), geom = "pointrange", color = "red") + theme_bw()
图片

6. 加框，包含中位数及四分位数
添加箱式图，非常简单其实就是图像的叠加，使用geom_boxplot()即可，注意调整一下width。

ggplot(mpg, aes(x = class, y = hwy)) + geom_violin(trim = FALSE) + geom_boxplot(width = 0.2) +
    theme_bw()
图片

7. 改变边框颜色
设置边框颜色 (color)，如下：

ggplot(mpg, aes(x = class, y = hwy)) + geom_violin(aes(color = class), trim = FALSE) +
    theme_bw()
图片

8. 改变填充色
设置填充颜色 (fill)，如下：

ggplot(mpg, aes(x = class, y = hwy)) + geom_violin(aes(fill = class), trim = FALSE) +
    theme_bw()
图片

9. 自定义边框颜色
ggplot(mpg, aes(x = class, y = hwy)) + geom_violin(aes(color = class), trim = FALSE) +
    theme_minimal() + scale_color_manual(values = rainbow(7)) + theme_bw()
图片

10. 自定义填充颜色
ggplot(mpg, aes(x = class, y = hwy)) + geom_violin(aes(fill = class), trim = FALSE) +
    theme_minimal() + scale_fill_manual(values = rainbow(7)) + theme_bw()
图片

11. 添加分组变量
对边框颜色进行修改，添加分组变量，如下：

ggplot(mpg, aes(x = class, y = hwy)) + geom_violin(aes(color = year), trim = FALSE) +
    theme_bw()
图片

12. 修改填充颜色
对填充颜色进行修改，添加分组变量，如下：

ggplot(mpg, aes(x = class, y = hwy)) + geom_violin(aes(fill = year), trim = FALSE) +
    scale_fill_manual(values = c("#999999", "#E69F00")) + theme_bw()
图片

13. 添加散点
在小提琴上添加散点(geom_point)，如下：

ggplot(mpg, aes(x = class, y = hwy)) + geom_violin(trim = FALSE) + geom_point(position = position_jitter(0.2)) +
    theme_bw()
图片

14. 添加抖动点
在小提琴上添加抖动点(geom_jitter)，如下：

ggplot(mpg, aes(x = class, y = hwy)) + geom_violin(trim = FALSE) + geom_jitter(shape = 16,
                                                                               size = 2, position = position_jitter(0.2)) + theme_bw()
图片

15. 添加箱图和抖动点
在小提琴上同时添加箱式图(geom_boxplot)和抖动点(geom_jitter),注意还需要调整箱图的宽度(width)和抖动点的大小，位置和形状等。

ggplot(mpg, aes(x = class, y = hwy)) + geom_violin(trim = FALSE) + geom_boxplot(width = 0.2) +
    geom_jitter(shape = 16, size = 1, position = position_jitter(0.2)) + theme_bw()
图片

16. 双样本组间比较
在小提琴图上条件一些统计量，比如P值和显著性等统计结果，这里同样也要考虑不同比较情况时采用的统计学方法是不同的。

Wilcox(秩合检验)
秩合检验适合大样本量，先对给出来比较的分组，然后在绘制图形，如下：

comparisons <- list(c("setosa", "versicolor"), c("versicolor", "virginica"), c("setosa",
                                                                               "virginica"))
ggplot(iris, aes(Species, Sepal.Length, fill = Species)) + geom_violin() + geom_boxplot(width = 0.2) +
    geom_jitter(shape = 16, size = 2, position = position_jitter(0.2)) + geom_signif(comparisons = comparisons,
                                                                                     map_signif_level = T, textsize = 6, test = wilcox.test, step_increase = 0.2) +
    guides(fill = FALSE) + xlab(NULL) + theme_classic()
图片

也可以通过ggpubr软件包一次完成，如下：

library(ggpubr)
ggviolin(iris, x = "Species", y = "Sepal.Length", fill = "Species", palette = c("lancet"),
         add = "boxplot", add.params = list(fill = "white"), order = c("virginica", "versicolor",
                                                                       "setosa"), error.plot = "errorbar") + stat_compare_means(comparisons = comparisons)
图片

T检验
T检验适合小样本量，一般样本量小于30个，如下：

library(ggsci)
p1<-ggplot(iris, aes(Species, Sepal.Length, fill = Species)) + 
    geom_violin()+
    geom_boxplot(width = 0.2) + 
    scale_fill_jco() +
    geom_jitter(shape = 16, size = 1, position = position_jitter(0.2)) + 
    geom_signif(comparisons = comparisons, 
                map_signif_level = F, 
                textsize =3, 
                test = t.test, 
                step_increase = 0.2) + 
    guides(fill = F) + xlab(NULL) +
    theme_classic()
## Warning: `guides(<scale> = FALSE)` is deprecated. Please use `guides(<scale> =
## "none")` instead.
p1
图片

17. 多组样本比较
方差分析
我们还可以在stat_compare_means函数里面设置不同的参数，这里默认使用wilcox检验，最后一个stat_compare_means函数还可以使用方差分析（method=""anova")。

p2 <- ggplot(iris, aes(Species, Sepal.Length, fill = Species)) + geom_violin() +
    geom_boxplot(width = 0.2) + scale_fill_jco() + geom_jitter(shape = 16, size = 1,
    position = position_jitter(0.2)) + stat_compare_means(method = "anova") + guides(fill = FALSE) +
    theme_classic() + xlab("")
p2
图片

Kruskal-Wallis检验
在这里我们运用Kruskal-Wallis检验。具体原理，具体原理本文不做阐述，读者请移步非参数统计的相关内容。这里会用到ggpubr包。

ggplot(iris, aes(Species, Sepal.Length, fill = Species)) + geom_violin() + geom_boxplot(width = 0.2) +
    scale_fill_jco() + geom_jitter(shape = 16, size = 2, position = position_jitter(0.2)) +
    stat_compare_means() + guides(fill = FALSE) + theme_classic()
图片

18. 添加p值和显著性
添加p值
library(reshape2)
iris %>%
    melt() %>%
    ggplot(aes(variable, value, fill = Species)) + geom_violin() + scale_fill_jco() +
    stat_compare_means(label = "p.format") + facet_grid(. ~ variable, scales = "free",
    space = "free_x") + theme_bw() + theme(axis.text.x = element_blank()) + xlab(NULL) +
    guides(fill = FALSE)
图片

添加显著性
iris %>%
    melt() %>%
    ggplot(aes(variable, value, fill = Species)) + geom_violin() + scale_fill_jco() +
    stat_compare_means(label = "p.signif", label.x = 1.5) + facet_grid(. ~ variable,
    scales = "free", space = "free_x") + theme_bw() + theme(axis.text.x = element_blank()) +
    guides(fill = FALSE)
图片

19. 双数据小提琴图
绘制分半小提琴图的代码来源：

https://gist.github.com/Karel-Kroeze/746685f5613e01ba820a31e57f87ec87

source("split_violin_ggplot.R")
简单双数据小提琴图
我们这里分组比较的是1999年和2008年的情况，然后设计出来抖动点的位置，这样可以避免点的重合，如下：

comparisons = list(c("1999", "2008"))
mpg <- transform(mpg, dist_cat_n = as.numeric(as.factor(mpg$class)), scat_adj = ifelse(year ==
    "1999", -0.15, 0.15))
mpg$year = factor(mpg$year)
head(mpg)
##   manufacturer model displ year cyl      trans drv cty hwy fl   class
## 1         audi    a4   1.8 1999   4   auto(l5)   f  18  29  p compact
## 2         audi    a4   1.8 1999   4 manual(m5)   f  21  29  p compact
## 3         audi    a4   2.0 2008   4 manual(m6)   f  20  31  p compact
## 4         audi    a4   2.0 2008   4   auto(av)   f  21  30  p compact
## 5         audi    a4   2.8 1999   6   auto(l5)   f  16  26  p compact
## 6         audi    a4   2.8 1999   6 manual(m5)   f  18  26  p compact
##   dist_cat_n scat_adj
## 1          2    -0.15
## 2          2    -0.15
## 3          2     0.15
## 4          2     0.15
## 5          2    -0.15
## 6          2    -0.15
ggplot(mpg, aes(x = class, y = hwy, fill = year)) + geom_split_violin(trim = T, draw_quantiles = 0.5) +
    geom_jitter(aes(scat_adj + dist_cat_n, y = hwy, fill = year), position = position_jitter(width = 0.1,
        height = 0), shape = 21, size = 1) + theme_bw() + xlab("")
图片

修改颜色
ggplot(mpg, aes(x = class, y = hwy, fill = year)) + geom_split_violin(trim = T, draw_quantiles = 0.5) +
    geom_jitter(aes(scat_adj + dist_cat_n, y = hwy, fill = year), position = position_jitter(width = 0.1,
        height = 0), shape = 21, size = 1) + scale_fill_manual(values = c("#197EC099",
"#FED43999")) + theme_bw() + xlab("")
图片

添加P值
ggplot(mpg, aes(x = class, y = hwy, fill = year)) + geom_split_violin(trim = T, draw_quantiles = 0.5) +
    geom_jitter(aes(scat_adj + dist_cat_n, y = hwy, fill = year), position = position_jitter(width = 0.1,
                                                                                             height = 0), shape = 21, size = 1) + scale_fill_manual(values = c("#197EC099",
                                                                                                                                                               "#FED43999")) + stat_compare_means(data = mpg, aes(x = class, y = hwy), label = "p.format",
                                                                                                                                                                                                  method = "t.test") + theme_bw() + xlab("")
图片

添加显著性
p3 <- ggplot(mpg, aes(x = class, y = hwy, fill = year)) + geom_split_violin(trim = T,
                                                                            draw_quantiles = 0.5) + geom_jitter(aes(scat_adj + dist_cat_n, y = hwy, fill = year),
                                                                                                                position = position_jitter(width = 0.1, height = 0), shape = 21, size = 1) +
    scale_fill_manual(values = c("#197EC099", "#FED43999")) + stat_compare_means(data = mpg,
                                                                                 aes(x = class, y = hwy), label = "p.signif", method = "t.test") + theme_bw() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) + xlab("")
p3
图片

19. 云雨图
云雨图，顾名思义，像云和雨一样的图。由两个部分组成：上图像云，本质上是小提琴的一半；下图像雨，本质上是蜂窝图的一半，主要用于数据分布的展示。

我们需要下载大牛的源码：

https://github.com/hadley/ggplot2/blob/master/R/geom-violin.r

source("geom-violin.R")
竖直云雨图
使用geom_split_violin()函数绘制分半的小提琴图代码如下：

library(grid)
p4 <- ggplot(mpg, aes(x = class, y = hwy, fill = year)) + geom_flat_violin(aes(fill = class),
                                                                           position = position_nudge(x = 0.25), color = "black") + geom_jitter(aes(color = class),
                                                                                                                                               width = 0.1) + geom_boxplot(width = 0.1, position = position_nudge(x = 0.25),
                                                                                                                                                                           fill = "white", size = 0.5) + theme_light() + theme(legend.position = "none") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))

p4
图片

水平云雨图
p5 <- ggplot(mpg, aes(x = class, y = hwy, fill = year)) + geom_flat_violin(aes(fill = class),
                                                                           position = position_nudge(x = 0.25), color = "black") + geom_jitter(aes(color = class),
                                                                                                                                               width = 0.1) + geom_boxplot(width = 0.1, position = position_nudge(x = 0.25),
                                                                                                                                                                           fill = "white", size = 0.5) + coord_flip() + theme_light() + theme(legend.position = "none")
p5
图片

20. 组合小提琴图
选择几个小提琴图进行组图，组合后的效果如下：

library(patchwork)
(p1 | p2 | p3)/(p4 | p5)
图片

21. 高颜值小提琴图(ggstatsplot)
ggstatsplot是ggplot2的扩展，用于绘制带有统计检验信息的图形。ggstatsplot采用典型的探索性数据分析工作流，将数据可视化和统计建模作为两个不同的阶段；可视化为建模提供依据，模型反过来又可以提出不同的可视化方法。ggstatsplot的思路就是将这两个阶段统一在带有统计细节的图形中，提高数据探索的速度和效率。

ggstatsplot提供了多种类别的统计绘图。用户可以在图形上添加统计建模（假设检验和回归分析）的结果，可以进行复杂的图形拼接，并且可以在多种背景和调色板中进行选择，使图形更美观。ggstatsplot和它的后台组件还可以和其他基于ggplot2的R包结合起来使用。



ggbetweenstats
ggbetweenstats函数用于创建小提琴图、箱形图或组间或组内比较的组合图。此外，该函数还有一个grouped_变量，可以方便地在单个分组变量上重复相同的操作。

library(ggstatsplot)
if (require("PMCMRplus")) {
    # to get reproducible results from bootstrapping
    set.seed(123)
    library(ggstatsplot)
    library(dplyr, warn.conflicts = FALSE)
    library(ggplot2)
    
    # the most basic function call
    grouped_ggbetweenstats(data = filter(ggplot2::mpg, drv != "4"), x = year, y = hwy,
                           grouping.var = drv)
    
    # modifying individual plots using `ggplot.component` argument
    grouped_ggbetweenstats(data = filter(movies_long, genre %in% c("Action", "Comedy"),
                                         mpaa %in% c("R", "PG")), x = genre, y = rating, grouping.var = mpaa, ggplot.component = scale_y_continuous(breaks = seq(1,
                                                                                                                                                                 9, 1), limits = (c(1, 9))))
}
图片

ggwithinstats
gbetweenstats函数有一个用于重复度量设计的相同的孪生函数ggwithinstats，两个函数以相同的参数运行，但ggbetweenstats引入了一些小的调整，以正确地可视化重复度量设计。从下面的例子中可以看出，结构的唯一区别是，ggbetweenstats通过路径将重复度量连接起来，以突出数据类型。

if (require("PMCMRplus")) {
    # to get reproducible results from bootstrapping
    set.seed(123)
    library(ggstatsplot)
    library(dplyr, warn.conflicts = FALSE)
    library(ggplot2)
    
    # the most basic function call
    grouped_ggwithinstats(
        data             = filter(bugs_long, condition %in% c("HDHF", "HDLF")),
        x                = condition,
        y                = desire,
        grouping.var     = gender,
        type             = "np",  # non-parametric test
        # additional modifications for **each** plot using `{ggplot2}` functions
        ggplot.component = scale_y_continuous(breaks = seq(0, 10, 1), limits = c(0, 10))
    )
}
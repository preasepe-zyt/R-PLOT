devtools::install_github("ricardo-bion/ggradar", 
                         dependencies = TRUE)
c$group <- rownames(c)
as.data.frame(c) -> c
library(ggradar)
ggradar(mental, base.size = 15,
        font.radar = 'sans', 
        text family values.radar = c("0%", "50%", "100%"),
        #values to print at minimum, 'average', and maximum gridlines axis.labels = colnames(data)[-1], #axis names grid.min = 0, 
        # value at which mininum grid line is plotted grid.mid = 0.5, 
        # value at which average grid line is plotted grid.max = 1, 
        # value at which maximum grid line is plotted centre.y = 0, 
        # 保证data中的所有值大于等于centre.y就行 plot.extent.x.sf = 0.76, # 控制水平方向的距离 plot.extent.y.sf =1.15, # 控制垂直方向的距离 x.centre.range =1, 
        # 雷达标签沿着水平方向偏离的程度 label.centre.y = F, 
        # 是否显示Y轴的中心 grid.line.width = 0.5, 
        # 雷达坐标轴线的粗细 gridline.min.linetype = 2, 
        # line type of minimum gridline gridline.mid.linetype = 2, 
        # line type of average gridline gridline.max.linetype = 2, 
        # line type of maximum gridline gridline.min.colour = "grey", 
        # colour of minimum gridline gridline.mid.colour = "#007A87", 
        # colour of average gridline gridline.max.colour = "grey", 
        # colour of maximum gridline grid.label.size = 4, 
        # text size of gridline label gridline.label.offset = -0.08, 
        # gridline label 偏离中心的水平距离，负数向左，正数向右 label.gridline.min = T, label.gridline.mid = T, label.gridline.max = T, 
        # 是否显示这三条线的label axis.label.offset = 1.15, 
        # 以圆心为中心，雷达标签沿着半径向外的距离 axis.label.size = 5, 
        # 雷达标签的字体大小 axis.line.colour = '#D7D6D1', 
        # 雷达坐标轴也就是直径的颜色 group.line.width = 0.8, 
        # 图中线条的粗细 group.point.size = 3, 
        # 图中点的大小 group.colours = pal_npg(alpha = 0.7)(nrow(data)), 
        # 分组的颜色 background.circle.colour = "#D7D6D1",
        # 背景的颜色 background.circle.transparency = 0.2, 
        # 背景颜色的透明度 plot.legend = T, 
        # 是否展示图例 legend.title = "", 
        # 图例的标题 plot.title = "", 
        # 雷达图的标题 legend.text.size = 12, 
        # 图例字体的大小 legend.position = "right" 
        # 图例的位置
library(ggradar)
library(dplyr)
library(scales)
library(tibble)
mtcars_radar <- mtcars %>%
  as_tibble(rownames = "group") %>%
  mutate_at(vars(-group), rescale) %>%
  tail(4) %>%
  select(1:10)
mtcars_radar
ggradar( a,
         legend.position = "left",
         font.radar = "sans",
        #plot.extent.x.sf = 10,
        #plot.extent.y.sf = 110,
        grid.min = 0,
        grid.max = 100,
        grid.line.width = 0.1,
        group.line.width = 1,
        group.point.size = 4
        )

ggradar(a)

c3 %>% as_tibble(rownames = "group") -> c3
c3$group <- C$组别
library(radarchart)
data1 <- as.data.frame(t(data[,-1]))
colnames(data1) <- paste0('S',1:4)
chartJSRadar(a,
             width = 7, # Width of output plot
             height = 7, # Height of output plot
             polyAlpha = 0, # 调整填充的透明度0-1
             scaleStepWidth = 100)


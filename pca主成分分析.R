
library(devtools)
install_github("vqv/ggbiplot")
library(ggbiplot)
# 使用内置数据演示
data(wine)
head(wine)
PCA分析
wine.pca <- prcomp(benew3, scale. = TRUE)
# 可视化
ggbiplot(wine.pca, # PCA结果
         choices = c(1,2), # 主成分选择
         obs.scale = 1, # 标准化观测值
         var.scale = 1, # 标准化变量
         var.axes = FALSE, #为变量画箭头
         #groups = group, 
         ellipse = TRUE, # 置信椭圆
         ellipse.prob = 0.95, # 置信区间，默认0.68
         circle = F) +  # 画相关圈(仅适用于当scale = TRUE和var.scale = 1时调用prcomp)
  #scale_color_manual(values = c('#fb9b8e','#00ac4c','#70abd8'))+
  theme_bw() +
  theme(legend.direction = 'horizontal', 
        legend.position = 'top',
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 16))
ggsave('pca.pdf',width = 5, height = 5)

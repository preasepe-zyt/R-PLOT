
# 安装包
install.packages("esquisse")
#载入包
library(esquisse)

#这里用的是mtcars数据集
data  <-  data(mtcars)
#打开可视化界面
esquisse:::esquisser()

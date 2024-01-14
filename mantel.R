
#安装devtools
install.packages("devtools")
#方法1：分步演示图形绘制过程

set.seed(123)  # 随机种子

library(corrplot)#加载相关热图包

library(vegan)#加载vegan包

data("varechem")#加载vegan内置数据-理化数据

data("varespec")#加载vegan内置数据-物种数据

#数据准备

head(varechem)

head(varespec)

write.csv(varechem,file="D:/NUM/varechem.csv")

write.csv(varespec,file="D:/NUM/varespec.csv")

#先绘制相关性热图

cor_plot<-cor(varechem)

corrplot(cor_plot,method="color",type="upper",addrect=1,insig="blank",rect.col = "blue",rect.lwd = 2)

#然后计算左边的三个点（矩阵）与右边理化数据之间的mantel test的r值和p值

mt<-function(varespec,varechem)
  
library(vegan)

library(dplyr)

vars <- colnames(varechem)

models<-list()

for (i in seq_along(vars)){
  
  otu_bray<-vegdist(varespec,method = "bray")
  
  env_dis<-vegdist(varechem[vars[i]],method = "euclidean")
  
  model <- mantel(otu_bray,env_dis, permutations=999)
  
  name <- vars[i]
  
  statistic <- model$statistic
  
  signif <- model$signif
  
  models[[i]] <- data.frame(name = name, statistic = statistic, signif = signif, row.names = NULL)
  
}

models %>% bind_rows()

#定义提取Mantel tests的R和p值

Total<-mt(varespec,varechem)#提取总物种数据与环境因子数据间的R和p值

mantRpsub1<-mt(varespec[,1:22],varechem)

#将1到22分为一个小组，并计算物种数据与环境因子数据间的R和p值

mantRpsub2<-mt(varespec[,-(1:22)],varechem)

#定义左边三个点的坐标位置

n <- ncol(varechem)

grp <- c('Total', 'Sub1', 'Sub2') # 分组名称

subx <- c(-3, -1, 1) # 分组的X坐标

suby <- c(7, 4, 1) # 分组的Y坐标

df <- data.frame(grp = rep(grp, each = n), # 分组名称，每个重复n次
                 
                 subx = rep(subx, each = n), # 组X坐标，每个重复n次
                 
                 suby = rep(suby, each = n), # 组Y坐标，每个重复n次
                 
                 x = rep(0:(n - 1) - 0.5, 3), # 变量连接点X坐标
                 
                 y = rep(n:1, 3) # 变量连接点Y坐标
                 
)

df2 <-rbind(Total, mantRpsub1, mantRpsub2)

df_segment<-cbind(df,df2)

df_segment <- df_segment %>% 
  
  mutate(
    
    lcol = ifelse(signif <= 0.001, '#1B9E77', NA), 
    
    # p值小于0.001时，颜色为绿色，下面依次类推
    
    lcol = ifelse(signif > 0.001 & signif <= 0.01, '#88419D', lcol),
    
    lcol = ifelse(signif > 0.01 & signif <= 0.05, '#A6D854', lcol),
    
    lcol = ifelse(signif > 0.05, '#B3B3B3', lcol),
    
    lwd = ifelse(statistic >= 0.3,6, NA),
    
    # statistic >= 0.3 时，线性宽度为6，下面依次类推
    
    lwd = ifelse(statistic >= 0.15 & statistic < 0.3, 3, lwd),
    
    lwd = ifelse(statistic < 0.15, 1, lwd)
    
  )

dev.new(
  
  title = "mantel test",
  
  width = 16,
  
  height = 8,
  
  noRStudioGD = TRUE
  
)

#绘制右边热图

corrplot(cor(varechem),method = "color",type = "upper", addrect = 1,insig="blank",rect.col = "blue",rect.lwd = 2)

hesegments(df_segment$subx, df_segment$suby, df_segment$x, df_segment$y, lty = 'solid', lwd = df_segment$lwd, col = df_segment$lcol, xpd = TRUE)

#设置点的位置和形状

points(subx, suby, pch = 24, col = 'blue', bg = 'blue', cex = 2, xpd = TRUE)

#设置文本位置

text(subx - 0.5, suby, labels = grp, adj = c(0.8, 0.5), cex = 1.2, xpd = TRUE)



#方法2：使用ggcor绘制图形【简单】

library(vegan)

library(ggcor)

library(ggplot2)#一定要加载

mantel <- mantel_test(varespec, varechem, 
                      
                      spec.select = list(Spec01 = 1:7,#依次定义四种物种作为Mantel的分析对象
                                         
                                         Spec02 = 8:18,
                                         
                                         Spec03 = 19:37,
                                         
                                         Spec04 = 38:44)) %>% 
  
mutate(rd = cut(r, breaks = c(-Inf, 0.2, 0.4, Inf),
                  
                  labels = c("< 0.2", "0.2 - 0.4", ">= 0.4")),#定义Mantel的R值范围标签，便于出图
         
pd = cut(p.value, breaks = c(-Inf, 0.01, 0.05, Inf),
                  
                  labels = c("< 0.01", "0.01 - 0.05", ">= 0.05")))#定义Mantel检验的p值范围标签，便于出图

dev.new(
  
  title = "mantel test",
  
  width = 16,
  
  height = 8,
  
  noRStudioGD = TRUE
  
)

quickcor(varechem, type = "upper") +#绘制理化数据热图
  
  geom_square() +#定义成方块状
  
  anno_link(aes(colour = pd, size = rd), data = mantel) +#定义连线
  
  scale_size_manual(values = c(0.5, 1, 2))+
  
  guides(size = guide_legend(title = "Mantel's r",#定义图例
                             
                             order = 2),
         
         colour = guide_legend(title = "Mantel's p", 
                               
                               order = 3),
         
         fill = guide_colorbar(title = "Pearson's r", order = 4))
         

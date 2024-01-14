library(ggplot2)
library(ggpubr)
library(ggpmisc)
theme_set(ggpubr::theme_pubr()+
          theme(legend.position = "top"))
# Load data
data("mtcars")
df <- mtcars
# Convert cyl as a grouping variable
df$cyl <- as.factor(df$cyl)
# Inspect the data
head(df[, c("wt", "mpg", "cyl", "qsec")], 4)
#查看散点的形状
ggpubr::show_point_shapes()
#显示版本一
ggscatter(df, x = "wt", y = "mpg",
          add = "reg.line", conf.int = TRUE,    
          add.params = list(fill = "lightgray"))+
stat_cor(method = "pearson", 
           label.x = 3, label.y = 30)
# Change color and shape by groups (cyl)
b <- ggplot(df, aes(x = wt, y = mpg))
b + geom_point(aes(color = cyl, shape = cyl))+
  geom_smooth(aes(color = cyl, fill = cyl), method = "lm") +
  geom_rug(aes(color =cyl)) +
  scale_color_manual(values = c("#00AFBB", "#E7B800", "#FC4E07"))+
  scale_fill_manual(values = c("#00AFBB", "#E7B800", "#FC4E07"))
# Remove confidence region (se = FALSE)
# Extend the regression lines: fullrange = TRUE
b + geom_point(aes(color = cyl, shape = cyl)) +
  geom_rug(aes(color =cyl)) +
  geom_smooth(aes(color = cyl), method = lm, 
              se = FALSE, fullrange = TRUE)+
  scale_color_manual(values = c("#00AFBB", "#E7B800", "#FC4E07"))+
  ggpubr::stat_cor(aes(color = cyl), label.x = 3)
  #facet_wrap(~cyl)
#回归
#自动拟合回归方程
b <- ggplot(df, aes(x = wt, y = mpg))

formula <- y ~ x

b + geom_point(shape = 17)+
  geom_smooth(method = "lm", color = "black", fill = "lightgray") +
  stat_cor(method = "pearson",label.x = 3, label.y = 30) +
  stat_poly_eq(
    aes(label = ..eq.label..),
    formula = formula,parse = TRUE, geom = "text",label.x = 3,label.y = 28, hjust = 0)
#拟合多项式方程
#创造样本
set.seed(4321)
x <- 1:100
y <- (x + x^2 + x^3) + rnorm(length(x), mean = 0, sd = mean(x^3) / 4)
my.data <- data.frame(x, y, group = c("A", "B"), 
                      y2 = y * c(0.5,2), block = c("a", "a", "b", "b"))
#拟合多项式回归
# Polynomial regression. Sow equation and adjusted R2
formula <- y ~ poly(x, 3, raw = TRUE)
p <- ggplot(my.data, aes(x, y2, color = group)) +
  geom_point() +
  geom_smooth(aes(fill = group), method = "lm", formula = formula) +
  stat_poly_eq(
    aes(label =  paste(..eq.label.., ..adj.rr.label.., sep = "~~~~")),
    formula = formula, parse = TRUE
  )+
  scale_fill_manual(values = c("#00AFBB", "#E7B800"))+
  scale_color_manual(values = c("#00AFBB", "#E7B800"))
p
'
注意：可以在 label 中添加 ..AIC.label.. 和 ..BIC.label.. ，
将会显示拟合方程的AIC值和BIC值。
stat_poly_eq()中的 label.x 和 label.y 可用于调整标签显示的位置。
想要查看更多的示例，请键入该命令进行查看：
browseVignettes("ggpmisc")
将打开如下网页：http://127.0.0.1:18537/session/Rvig.2970595b7d23.html
'''
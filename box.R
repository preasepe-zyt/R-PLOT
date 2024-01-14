library(ggplot2)
library(ggpubr)
library(readxl)
X2 <- read_excel("C:/Users/79403/Desktop/2.xlsx")
zoo::na.spline(X2) -> X2
#na.omit()
as.matrix(X2) -> X2
dim(X2) <- c(140,1)
name1 <- c(rep("CTL",28),rep("MPTP",28),rep("25ug/ml",28),rep("50ug/ml",28),rep("100ug/ml",28))
name3 <- c(rep("1",56),rep("2",56),rep("3",56),rep("3",56))
X2 <- data.frame(X2,name1)
X2 <- data.frame(X2,name3)
name2 <- c("len","group","fac")
colnames(X2) <- name2
p <- ggboxplot(X2, "group", "len", color = "group", palette = c("#00AFBB", "#E7B800","purple", "palevioletred","#FC4E07"))
my_comparisons <- list( c("CTL", "MPTP"), c("MPTP", "25ug"), c("MPTP", "50ug"),c("MPTP", "100ug") )
my_comparisons4 <- list( c("CTL", "MPTP"), c("MPTP", "25ug"), c("MPTP", "50ug"),c("MPTP", "100ug") )
p2 <- p+stat_compare_means(method = "t.test", label = "p.signif",comparisons = my_comparisons)

p+stat_compare_means(method = "anova", aes(label = "p.format"), label.x.npc = "left", label.y = 11,size = 4)

p+stat_compare_means(method = "anova", label.y = 40)+stat_compare_means(aes(label = ..p.signif..),method = "t.test", ref.group = "MPTP")
p + stat_anova_test(aes(group = group), label = "p = {p.format}{p.signif}")
p2 <- p +geom_signif(annotations = c("#", "##","###","***")
               ,y_position = c(300, 250, 200, 150)
               ,xmin = c(5, 4, 3, 2)
               ,xmax = c(2, 2, 2, 1)
               #,tip_length = c(0.05,0.4,0.05,0.2,0.05,0.01)
               ,color="black")
p3 <- p2 + xlab("group") + ylab("totaldistance")
p3

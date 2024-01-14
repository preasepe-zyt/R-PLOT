rm(list=ls())
library(tidyverse)
library(readxl)
library(xlsx)
library(ggplot2)
library(reshape2)
library(ggpubr)
library(dplyr)
library(ggbeeswarm)
library(cols4all)
library(cowplot)
zebrafish.be <- function(dat, nf, ng) {
    library(tidyverse)
    library(readxl)
    library(xlsx)
    library(ggplot2)
    library(reshape2)
    library(ggpubr)
    library(dplyr)
    if(class(dat) != "character"){
        return("this is not character")
    }else{
        abc <- as.data.frame(read_excel(dat))
    }
    if(class(nf) != "numeric"){
        return("nf is not numeric")
    }else{
        nfish <- nf #鱼的数量)
    }
    if(class(ng) != "numeric"){
        return("ng this is not numeric")
    }else{
        ngroup <- ng
    }
    interval <- nfish-1
    abc <- as.data.frame(read_excel(dat))
    abc <- select(abc,c("aname","start","end","inadist","smldist","lardist"))
    arrange(abc, abc[,1]) -> abc
    for (i in 1:nrow(abc)) {reduce(abc[i,c("inadist","smldist","lardist")],sum) -> abc$min_distance[[i]]}
    for (i in 1:nrow(abc)) {as.numeric(abc[i,"min_distance"])/60 -> abc$second_speed[i]}
    for (i in 1:nrow(abc)) {if (i%%nfish==0) reduce(abc[(i-interval):i,c("inadist","smldist","lardist")],sum) -> abc$total_distance[i%/%nfish]}
    abc$total_distance[(nrow(abc)%/%nfish+1):nrow(abc)] <- "NA"
    write.xlsx(abc,"自动处理.xlsx")
    graph <- list()
    group <- vector()
    for (i in 1:(nrow(abc)/nfish)) {if (i%%ngroup==0)  as.vector(abc$total_distance[(i-(ngroup-1)):i]) -> graph[[i]]}
    final_n <- vector()
    for (i in 1:(nrow(abc)/nfish)) {if (i%%ngroup  == 0 ) append(final_n,i) -> final_n}
    graph[final_n] %>% as.data.frame() -> graph2
    names(graph2) <- c(1:6)
    write.xlsx(graph2,"graph格式.xlsx")
    return(graph2)
    }
results <- zebrafish.be("zyt.xls", 20, 8)     
names(results) <- c("Ctl", "scopolamine", "10 µg/mL", "20 µg/mL", "40 µg/mL")
results <- results[,-6] %>% apply(2,as.numeric)
plot <- melt(results) 
names(plot) <- c("id", "group", "value")
my_comparisons <- list(c("Ctl", "scopolamine"), c("10 µg/mL", "scopolamine"), c("20 µg/mL", "scopolamine"), c("40 µg/mL", "scopolamine"))
if(T){mytheme <- theme(plot.title = element_text(size = 30,color="black",hjust = 0.5),
                     axis.title = element_text(size = 30,color ="black"), 
                     axis.text = element_text(size= 30,color = "black"),
                     panel.grid.minor.y = element_blank(),
                     panel.grid.minor.x = element_blank(),
                     axis.text.x = element_text(angle = 45, hjust = 1 ),
                     panel.grid=element_blank(),
                     legend.position = "right",
                     legend.text = element_text(size= 30),
                     legend.title= element_text(size= 30)
    ) }

ggplot(plot, aes(x = group, y = value))+ 
    labs(y="总距离",x= "分组",title = "")+  
    geom_boxplot(plot, mapping=aes(x = group, y = value,fill=group),position=position_dodge(0.5),width=0.5,outlier.alpha = 0)+ 
    theme_classic() + mytheme + 
    stat_compare_means(comparisons = my_comparisons,
                       label = "p.signif",
                       method = "wilcox.test",
                       hide.ns = T) -> p
p
ggsave("总距离.bmp", width = 10, height = 10, family="Arial",units = "cm")
abc$time <- rep(c(1:30),48)
gsub("^[^-]+","",abc$aname) -> abc$group

ggplot(plot, aes(x = group, y = value,group=group))+ 
    labs(y="总距离",x= "分组",title = "")+  
    geom_boxplot(plot, mapping=aes(x = group, y = value, color=group),position=position_dodge(0.5),width=0.5,outlier.alpha = 0)+ 
    theme_classic() + mytheme + 
    geom_jitter(aes(color=group))+
    scale_color_manual(values = rev(mycol))+
    stat_compare_means(comparisons = my_comparisons,
                       label = "p.signif",
                       method = "wilcox.test",
                       hide.ns = T) ->p2
ggsave("行为学.bmp", width = 10, height = 7, family="Arial")
c4a_gui()
mycol <- c4a('bold',8) #自定义配色挑选
ggplot(plot, aes(x = group, y = value))+ 
    labs(y="总距离",x= "分组",title = "")+  
    geom_beeswarm(aes(color = group), size = 2.2, alpha = 0.7,
                  cex = 1.3) +
    scale_color_manual(values = rev(mycol)) +
    theme_classic() + mytheme + 
    stat_compare_means(comparisons = my_comparisons,
                       label = "p.signif",
                       method = "wilcox.test",
                       hide.ns = F) -> p2
p2
plot_grid(p2,p2,p2,p2,labels = c("A","B","C","D"),nrow = 2, ncol=2, label_size = 100, label_fontface = "bold")
ggsave("行为学.bmp", width = 15, height = 15, family="Arial")

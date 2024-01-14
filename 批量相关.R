library(readxl)
correlation <- read_excel("correlation.xlsx", 
                          sheet = "Cal-middle")
var1 <- c()
var2 <- c()
name <- c()
for (i in 1:ncol(correlation)){
  for (i2 in i:ncol(correlation)) {
    var1 <- append(var1,names(correlation)[i])
    var2 <- append(var2,names(correlation)[i2])
    name <- append(name,paste(names(correlation)[i],names(correlation)[i2],sep = "-"))
  }
}
name <- paste(name,".pdf",sep="")

library(ggplot2)
library(ggpubr)
library(ggpmisc)

for (i in 1:ncol(correlation)){
  for (i2 in i:ncol(correlation)){
ggscatter(correlation, x = names(correlation)[i], y = names(correlation)[i2],
            add = "reg.line", conf.int = TRUE,    
            add.params = list(fill = "lightgray"))+
stat_cor(method = "pearson", 
             label.x = mean(correlation[[i]]), label.y =  mean(correlation[[i2]]),
             size=10)+
theme(text = element_text(family = "sans",size=10),
          plot.title = element_text(size = 30,color="black",hjust = 0.5),
          axis.title = element_text(size = 30,color ="black"), 
          axis.text = element_text(size= 30,color = "black"),
          #panel.grid.minor.y = element_blank(),
          #panel.grid.minor.x = element_blank(),
          axis.text.x = element_text(hjust = 1),
          axis.text.y = element_text(margin = margin(0,0,0,0.2,'cm')),
          axis.ticks.length.y = unit(.25, "cm"),
          axis.line = element_line(size = 0.8))
name <- paste(names(correlation)[i],names(correlation)[i2],sep = "-")
ggsave(paste(name,".pdf",sep = ""),width = 8, height = 6)
  
  }
}


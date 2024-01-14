library(ggpubr)
library(ggplot2)
library(ggplot2)
compare_means(f.att.1.237. ~ f.att.238.474. ,data=t,method = "t.test")
a <- ggplot()+
  geom_boxplot(f,mapping=aes(me,att),alpha=1, size=0.9, width=0.6,color=c("#35A585","#006FB0"))
a
b <- ggplot()+
  geom_boxplot(f,mapping=aes(w,att),alpha=1, size=0.9, width=0.6,color=c("#F2C661","#CC78A6"))
b
c<- ggplot()+
  geom_boxplot(f,mapping=aes(fe,att),alpha=1, size=0.9, width=0.6,color=c("#9DCD82","#F8B62D"))
c

a%>%insert_right(b) %>% insert_right(c)

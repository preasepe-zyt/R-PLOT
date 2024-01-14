bnc2$Group.1 <- factor(bnc2$Group.1,levels=c( "ctl", "30ug/ml", "60ug/ml","100ug/ml", "120ug/ml", "150ug/ml"
))
c(rep(" ",1),rep("30 μg/mL",1),rep("60 μg/mL",1),rep("100 μg/mL",1),rep("120 μg/mL",1),rep("150 μg/ml",1)) -> group1
library(ggplot2)
sigmoid <- function(x){1/(exp(-x)+1)}
mean <- function(x){mean(x)}
sd <- function(x){sd(sd)}
#shape
ggplot(bnc2,aes(Group.1,x))+
  geom_point(aes(Group.1,x,shape=Group.1),size=3)+
  #geom_errorbar(aes(ymin=mean(mor)-sd(mor), ymax=mean(mor)+sd(mor)),width=0.4)+
  theme_classic()+
  geom_line(group=1)+
  labs(x = "Concentrations (μg/mL)", y = "Mortality (100%)")+
  geom_hline(aes(yintercept = 50),linetype="dashed", size=1.2, colour="gray56")+
  theme(axis.title.x =element_text(size=15), axis.title.y=element_text(size=15),axis.text =element_text(size=10))+
  geom_label(aes(label = group),  nudge_y = 5,  alpha = 0.1,size=4,label.size = NA)+
  annotate("rect",
           xmin = c("57C","64A"),
           xmax = c("64A","VPA"),
           ymin = 0, ymax = 1000, alpha = 0.2, fill = c("gray50","black")) ->z1
x <- seq(-5, 5, 0.01)
plot(x,sigmoid(x),col='orange')
plot(sigmoid(x))
help(sigmoid)
